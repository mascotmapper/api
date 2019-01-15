#!/usr/bin/env python
"""
mascot: a microservice for serving mascot data
"""
import json
from flask import Flask, jsonify, abort, make_response

APP = Flask(__name__)

# Load the data
MASCOTS = json.load(open('data.json', 'r'))

@APP.route('/', methods=['GET'])
def get_mascots():
    """
    Function: get_mascots
    Input: none
    Returns: A list of mascot objects
    """
    return jsonify(MASCOTS)

@APP.route('/<guid>', methods=['GET'])
def get_mascot(guid):
    """
    Function: get_mascot
    Input: a mascot GUID
    Returns: The mascot object with GUID matching the input
    """
    for mascot in MASCOTS:
        if guid == mascot['guid']:
            return jsonify({'mascots', mascot})
    abort(404)
    return None

@APP.errorhandler(404)
def not_found(error):
    """
    Function: not_found
    Input: The error
    Returns: HTTP 404 with the error
    """
    return make_response(jsonify({'error': 'not found'}), 404)

if __name__ == '__main__':
    APP.run(debug=True)