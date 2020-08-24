# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateOrderWorker, type: :worker do
  describe '#worker' do
    let(:payload) do
      { order_id: 3,
        address: {
          city: "São Paulo",
          neighborhood: "Maua",
          street: "Rua Skenaro Nakandakare",
          uf: "SP",
          zip_code: "09361-080"
        }
      }
    end

    context 'when location is valid' do
      let(:address) do
        double(
          latitude: -23.5943976,
          longitude: -46.6799188
        )
      end

      before do
        expect(Geocoder).to receive(:search).and_return([address])
      end

      it 'update order  with latitude and longitude' do
        expect(OrderService::Client).to receive(:geolocation)
        subject.work(payload)
      end

      it 'returns :ack' do
        allow(OrderService::Client).to receive(:geolocation)

        expect(subject.work(payload)).to eq(:ack)
      end
    end

    context 'when location is not valid' do
      before do
        expect(Geocoder).to receive(:search).and_return([])
      end

      it 'does not update order with latitude and longitude' do
        expect(OrderService::Client).to_not receive(:geolocation)
        subject.work(payload)
      end

      it 'returns :ack' do
        expect(subject.work(payload)).to eq(:ack)
      end
    end
  end
end
