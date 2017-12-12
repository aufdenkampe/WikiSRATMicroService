import re

class StringParser:
    @classmethod
    def parse(self,input_string):
        try:
            output = [{}]
            input_variables = re.findall(r'\w+\s\([^)]+\)',input_string)
            for input_variable in input_variables:
                try:
                    variable_name = re.match(r'\w+',input_variable).group(0)
                except AttributeError:
                    raise AttributeError("Variable name invalid ("+input_variable+")")
                try:
                    data_as_string = re.search(r'\([^)]+\)',input_variable).group(0)
                except AttributeError:
                    raise AttributeError("Value string invalid (" + input_variable + ")")
                data_values = eval(data_as_string)
                if type(data_values) != tuple:
                    raise AttributeError("Value string not properly formatted (" + data_as_string + ")")
                for i,data_value in enumerate(data_values):
                    if(len(output) < i+1):
                        if(variable_name == "huc12"):
                            output.append({})
                        else:
                            print(i)
                            raise AttributeError("Inconsistent number of values (" +variable_name + ")")
                    output[i][variable_name] = data_value
            print(output)
            return output
        except AttributeError as e:
            raise e
        except Exception as e:
            print(e)
            raise AttributeError("input string was improperly formatted")