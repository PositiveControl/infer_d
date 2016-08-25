require 'rspec'
require_relative './date_parser.rb'

describe DateParser do
  context 'parsing various various formats' do
    it 'should parse MM/DD/YYYY' do
      date = "12/31/1999"
      format = DateParser.infer_format(date)
      expect(DateParser.parse(date, format)).to eql(Date.new(1999,12,31))
    end

    it 'should parse YYYY/MM/DD' do
      date = "1999/12/31"
      format = DateParser.infer_format(date)
      expect(DateParser.parse(date, format)).to eql(Date.new(1999,12,31))
    end

    it 'should parse DD/MM/YYYY' do
      date = "31/12/1999"
      format = DateParser.infer_format(date)
      expect(DateParser.parse(date, format)).to eql(Date.new(1999,12,31))
    end
  end

  describe 'infers date format' do
    context 'slash delmited dates' do
      it 'should return DD/MM/YYYY' do
        dates_array = ["12/12/1999", "11/12/1999", "31/12/1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:alpha_dmy)
      end

      it 'should return MM/DD/YYYY' do
        dates_array = ["12/12/1999", "12/11/1999", "12/31/1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:mdy)
      end

      it 'should return YYYY/MM/DD' do
        dates_array = ["1999/12/12", "1999/12/11", "1999/12/31"]
        expect(DateParser.infer_format(dates_array)).to eql(:ymd)
      end
    end

    context 'dash delimited dates' do
      it 'should return :dmy' do
        dates_array = ["12-12-1999", "11-12-1999", "31-12-1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:alpha_dmy)
      end

      it 'should return :mdy' do
        dates_array = ["12-12-1999", "12-11-1999", "12-31-1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:mdy)
      end

      it 'should return :ymd' do
        dates_array = ["1999-12-12", "1999-12-11", "1999-12-31"]
        expect(DateParser.infer_format(dates_array)).to eql(:ymd)
      end
    end

    context 'Alphanumeric dates' do
      it 'should return :dmy when day is first' do
        dates_array = ["31st Dec, 1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:alpha_dmy)
      end

      it 'should return :dmy when month is first' do
        dates_array = ["Dec 31st, 1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:alpha_dmy)
      end

      it 'should return :dmy when month is first (full month)' do
        dates_array = ["December 31st, 1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:alpha_dmy)
      end

      it 'should return :dmy when month is first - no postfix' do
        dates_array = ["Dec 31, 1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:alpha_dmy)
      end

      it 'should return :dmy when day is first - no postfix' do
        dates_array = ["31 Dec, 1999"]
        expect(DateParser.infer_format(dates_array)).to eql(:alpha_dmy)
      end
    end
  end
end
