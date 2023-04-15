class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end
  
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end


  post '/baked_goods' do
    baked_good = BakedGood.new(params)
    if baked_good.save
      baked_good.to_json
    else
      halt 422, { error: "Failed to create baked good" }.to_json
    end
  end

  patch '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    if bakery.update(params) # Update to pass params directly
      bakery.to_json
    else
      halt 422, { error: "Failed to update bakery" }.to_json
    end
  end
  
  delete '/baked_goods/:id' do
    baked_good = BakedGood.find(params[:id])
    if baked_good.destroy
      status 204
    else
      halt 422, { error: "Failed to delete baked good" }.to_json
    end
  end
  
end
