class AddPointsToSeller
  def self.call(transaction)
    seller = transaction.seller

    success = false
    seller.transaction do
      seller.points += transaction.points

      archive = Archive.new(seller_id: transaction.seller_id, buyer_id: transaction.buyer_id,
        listing_id: transaction.listing_id, points: transaction.points, serial_number: transaction.serial_number,
        room_id: transaction.room_id)
      
      # TODO: Investigate this
      success = seller.save
      success = archive.save && success
      success = transaction.destroy && success
    end
    
    return success
  end
end