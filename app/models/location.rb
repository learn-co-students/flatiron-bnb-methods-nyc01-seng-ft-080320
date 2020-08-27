module Location
    module InstanceHelper
        def _openings (start_date, end_date)
            self.listings.filter do |listing|
            listing.available?(start_date, end_date)
            end
        end
        
        def reservations_total
            self.listings.reduce(0) do |count, listing|
            count + listing.reservations_count
            end
        end
        
        def ratio_res_to_listings

            highest = self.listings.reduce do |listing_a, listing_b|
                listing_a.reservations_count > listing_b.reservations_count ? listing_a : listing_b
            end
            if highest
                highest.reservations_count
            else
                0
            end
        end
    end
    module ClassHelper
        def highest_ratio_res_to_listings
           
            highest = self.all.reduce do |loc1, loc2|
                loc1.ratio_res_to_listings > loc2.ratio_res_to_listings ? loc1 : loc2
            end
        end

        def most_res
            self.all.reduce do |city1, city2|
                city1.reservations_total > city2.reservations_total ? city1 : city2
            end
        end
    end
end