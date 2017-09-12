require 'spec_helper'

describe 'Proximity Hash' do

  it 'calculates expected geohashes in distance order' do

    ph = ProximityHash.new(12.0, 77.0, 20.0, 8)
    hashes = ph.calculate

    expected = [
      'tdnu20tc', 'tdnu20t9',
      'tdnu20tb', 'tdnu20t8',
      'tdnu20tf', 'tdnu20td',
      'tdnu20mz', 'tdnu20mx',
      'tdnu20t3', 'tdnu20t2'
    ]

    expect(hashes.keys).to eq(expected)
  end

end