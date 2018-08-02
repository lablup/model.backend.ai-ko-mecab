#!/bin/python3
from flask import Flask, jsonify, abort, request
import MeCab

app = Flask(__name__)

messages = ['Success', 'Faild']

@app.route('/parse', methods=['POST'])
def parse():
    if not (request.json and 'sentence' in request.json):
        abort(400)

    sentence = request.json['sentence']
    results = mecab_parse(sentence)

    return mecab_response(200, messages[0], results, 'ko-dic')

@app.errorhandler(400)
def error400(error):
    return macab_response(400, messages[1], None, None)

def mecab_response(status, message, results, dic):
    return jsonify({'status': status, 'message': message, 'results': results, 'dict': dic}), status


def mecab_parse(sentence, dic='mecab-ko-dic'):
    dic_dir = "/usr/local/lib/mecab/dic/"
        dic_name = dic
    m = MeCab.Tagger('-d ' + dic_dir + dic_name)

    # 출력포멧
    format = ['형태소', '품사','품사-세분류1', '품사-세분류2', '품사-세분류3', '활용형', '활용구','원형',' ',' ']

    return [dict(zip(format, (lambda x: [x[0]]+x[1].split(','))(p.split('\t')))) for p in m.parse(sentence).split('\n')[:-2]]


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
