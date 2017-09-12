require 'spec_helper'

describe 'Proximity Hash' do

  it 'calculates expected geohashes' do

    ph = ProximityHash.ew(12.0, 77.0, 20.0, 8)
    hashes = ph.calculate


    expected = [
      'tdnu20t9', 'tdnu20t8', 'tdnu20t3', 'tdnu20t2', 'tdnu20mz', 'tdnu20mx',
      'tdnu20tc', 'tdnu20tb', 'tdnu20td', 'tdnu20tf'
    ]

    expect(hashes.keys).to.equal(expected)
  end

end