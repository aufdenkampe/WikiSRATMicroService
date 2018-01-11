import re
from constants import schema
from jsonschema import validate
from jsonschema import ValidationError


class StringParser:
    @classmethod
    def parse(self, input_string):
        try:
            parsed = self.string_to_ob(input_string)
            validate(parsed, schema)
            return parsed
        except ValidationError as e:
            raise AttributeError(e.message)

    @classmethod
    def string_to_ob(self, input_string):
        try:
            output = []
            input_variables = re.findall(r'\w+\s\([^)]+\)', input_string)  # TODO:remove the ^)
            for input_variable in input_variables:
                variable_name = re.match(r'\w+', input_variable).group(0)
                data_as_string = re.search(r'\([^)]+\)', input_variable).group(0)
                data_values_as_strings = data_as_string[1:-1].split(",")
                for i, data_value_as_string in enumerate(data_values_as_strings):
                    data_value = self.convert_string_to_valid_type(data_value_as_string)
                    if (len(output) < i + 1):
                        if (variable_name == "huc12"):
                            output.append({})
                        else:
                            print(i)
                            raise AttributeError("Inconsistent number of values (" + variable_name + ")")
                    output[i][variable_name] = data_value
            return output
        except AttributeError as e:
            raise e

    @classmethod
    def ob_to_string(self, object_in):
        temp = {}
        for huc12 in object_in:
            for attribute, value in huc12.items():
                try:
                    temp[attribute].append(value)
                except KeyError:
                    temp[attribute] = [value]
        temp_string = str(temp)
        temp_string = temp_string.replace("\'", "")
        temp_string = temp_string.replace(":", "")
        temp_string = temp_string.replace("[", "(")
        temp_string = temp_string.replace("]", ")")
        return "HotSpotMap(" + temp_string[1:-1] + ")"

    @classmethod
    def convert_string_to_valid_type(self, string_in):
        if (isinstance(string_in, str)):
            try:
                return int(string_in)
            except ValueError:
                try:
                    return float(string_in)
                except ValueError:
                    return string_in  # if all else fails return a string
        else:
            raise AssertionError("input is not a string")
