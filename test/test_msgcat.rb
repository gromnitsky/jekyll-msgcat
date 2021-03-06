# -*- coding: utf-8 -*-
require 'pp'
require 'ostruct'
require 'uri'

require '../lib/jekyll/msgcat'

# mock
module Site_ru
  def initialize *a, &b
    super
    @context = OpenStruct.new("registers" => {
                                site: OpenStruct.new("config" => {
                                                       'msgcat' => {
                                                         'locale' => 'ru'
                                                       }
                                                     }),
                                page: {
                                  'url' => '/foo/bar'
                                }
                              })

    @context_orig = @context
  end
end

require 'minitest/autorun'

class MsgcatTest < Minitest::Unit::TestCase
  include Site_ru
  include Jekyll::Msgcat

  def setup
    @context =  @context_orig
#    pp @context
  end

  def test_mc_empty
    refute mc nil
    assert_equal "", mc("")
  end

  def test_mc_no_msgcat_entry
    @context.registers[:site].config['msgcat'] = nil
    assert_equal "", mc("")
    assert_equal "News", mc("News")
  end

  def test_mc
    assert_equal "Новости", mc("News")
    assert_equal "news", mc("news")
    assert_equal "Напишите нам", mc("Write to Us")
  end

  def test_invalid_locale_name
    @context.registers[:site].config['msgcat']['locale'] = 'uk'
    out, err = capture_io do
      assert_equal "News", mc("News")
    end
    assert_match(/msgcat warning: 'uk' wasn't found/, err)
  end


  def test_cur_page_in_another_locale__this_locale
    assert_equal "<a href='#' class=' disabled'>ru</a>", cur_page_in_another_locale('ru')
  end

  def test_cur_page_in_another_locale__this_locale_custom_label
    assert_equal "<a href='#' class=' disabled'>Booo</a>", cur_page_in_another_locale('ru', 'Booo')
  end

  def test_cur_page_in_another_locale__this_locale_custom_class
    assert_equal "<a href='#' class='myclass1 myclass2 disabled'>ru</a>", cur_page_in_another_locale('ru', nil, "myclass1 myclass2")
  end

  def test_cur_page_in_another_locale__no_url_in_config
    @context.registers[:site].config['url'] = nil
    r = assert_raises(RuntimeError) do
      cur_page_in_another_locale 'lt'
    end
#    pp r
    assert_match(/bad argument/, r.to_s)
  end

  def test_cur_page_in_another_locale__domain_no_deploy
    @context.registers[:site].config['msgcat']['deploy'] = nil
    @context.registers[:site].config['url'] = 'http://lt.example.com'
    assert_equal "<a href='http://lt.example.com/foo/bar' class=' '>lt</a>", cur_page_in_another_locale('lt')
  end

  def test_cur_page_in_another_locale__domain_no_deploy_no_msgcat
    @context.registers[:site].config['msgcat'] = nil
    @context.registers[:site].config['url'] = 'http://lt.example.com'
    assert_equal "<a href='http://lt.example.com/foo/bar' class=' '>lt</a>", cur_page_in_another_locale('lt')
  end

  def test_cur_page_in_another_locale__domain
    @context.registers[:site].config['msgcat']['deploy'] = 'domain'
    @context.registers[:site].config['url'] = 'http://lt.example.com'
    assert_equal "<a href='http://lt.example.com/foo/bar' class=' '>lt</a>", cur_page_in_another_locale('lt')
  end

  def test_cur_page_in_another_locale__nearby_no_baseurl
    @context.registers[:site].config['msgcat']['deploy'] = 'nearby'
    @context.registers[:site].config['url'] = '/blog/lt'
    r = assert_raises(RuntimeError) do
      cur_page_in_another_locale 'lt'
    end
    assert_match(/no 'baseurl' property/, r.to_s)
  end

  def test_cur_page_in_another_locale__nearby
    @context.registers[:site].config['msgcat']['locale'] = 'uk'
    @context.registers[:site].config['msgcat']['deploy'] = 'nearby'
    @context.registers[:site].config['baseurl'] = '/blog/lt'
    assert_equal "<a href='/blog/lt/foo/bar' class=' '>lt</a>", cur_page_in_another_locale('lt')
  end

end
