using MeCab
using Base.Test

# assume using ipadic
mecab = Mecab()

results = parse(mecab, "今日の天気は晴れです")
@test length(results) == 6
@test isa(results[1], MecabResult)
@test results[1].surface == "今日"
@test results[1].feature == "名詞,副詞可能,*,*,*,*,今日,キョウ,キョー"

results = parse_surface(mecab, "今日の天気は晴れです")
@test length(results) == 6
@test isa(results[1], String)
@test results[1] == "今日"

nbest_results = parse_nbest(mecab, 3, "こんにちは")
@test length(nbest_results) == 3
@test length(nbest_results[1]) == 1
@test nbest_results[1][1].surface == "こんにちは"

result = sparse_tostr(mecab, "こんにちは")
@test result == "こんにちは\t感動詞,*,*,*,*,*,こんにちは,コンニチハ,コンニチワ\nEOS\n"

result = nbest_sparse_tostr(mecab, 3, "こんにちは")
@test result == "こんにちは\t感動詞,*,*,*,*,*,こんにちは,コンニチハ,コンニチワ\nEOS\nこん\t名詞,固有名詞,人名,名,*,*,こん,コン,コン\nに\t助詞,格助詞,一般,*,*,*,に,ニ,ニ\nち\t動詞,自立,*,*,五段・ラ行,体言接続特殊２,ちる,チ,チ\nは\t助詞,係助詞,*,*,*,*,は,ハ,ワ\nEOS\nこん\t動詞,自立,*,*,五段・マ行,連用タ接続,こむ,コン,コン\nに\t助詞,格助詞,一般,*,*,*,に,ニ,ニ\nち\t動詞,自立,*,*,五段・ラ行,体言接続特殊２,ちる,チ,チ\nは\t助詞,係助詞,*,*,*,*,は,ハ,ワ\nEOS\n"

MeCab.nbest_init(mecab, "こんにちは")
result = MeCab.nbest_next_tostr(mecab)
@test result == "こんにちは\t感動詞,*,*,*,*,*,こんにちは,コンニチハ,コンニチワ\nEOS\n"
result = MeCab.nbest_next_tostr(mecab)
@test result == "こん\t名詞,固有名詞,人名,名,*,*,こん,コン,コン\nに\t助詞,格助詞,一般,*,*,*,に,ニ,ニ\nち\t動詞,自立,*,*,五段・ラ行,体言接続特殊２,ちる,チ,チ\nは\t助詞,係助詞,*,*,*,*,は,ハ,ワ\nEOS\n"