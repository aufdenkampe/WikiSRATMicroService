import re
import json
from constants import schema
from jsonschema import validate as jsonvalidate
from jsonschema import ValidationError


class StringParser:
    @classmethod
    def parse(self, input_string):
        parsed = self.string_to_ob(input_string)
        self.validate(parsed)
        return parsed

    @classmethod
    def validate(self, object):
        try:
            jsonvalidate(object, schema)
        except ValidationError as e:
            raise AttributeError(e.message)

    @classmethod
    def string_to_ob(self, input_string):
        try:
            return json.loads(input_string)
        except json.decoder.JSONDecodeError as e:
            raise AttributeError(e.args[0])

    @classmethod
    def ob_to_string(self, object_in):
        return json.dumps(object_in)
