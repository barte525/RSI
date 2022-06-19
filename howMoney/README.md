# ⚙️ Server for HowMoney Application
## API Reference
### Alerts

#### Get all alerts

```
GET /api/Alert
```

Requires authorization: Bearer Token (JWT)

#### Post alert
```
POST /api/Alert/
```
Example request body:
```json
{
  "asset_name": "EUR",
  "currency": "PLN",
  "value": 4.5
}
```

Requires authorization: Bearer Token (JWT)

#### Delete alert

```
DELETE /api/Alert/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `int` | **Required**. Id of alert to delete |


### Assets

#### Get assets

```
GET /api/Asset
```

#### Create new Asset
```
POST /api/Asset
```

Example request body:
```json
{
  "type": "crypto",
  "name": "BTC",
  "converterPLN": 88636.02,
  "converterEUR": 18945.28,
  "converterUSD": 19883.8
}
```

#### Get asset
```
GET /api/Asset/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of alert to delete |


#### Delete asset
```
DELETE /api/Asset/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of alert to delete |

#### Change existing Asset
```
PUT /api/Asset/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of alert to delete |

Example request body:
```json
{
  "id": "3fa34f23-5723-45633-2b3fc-2c963f66af1a"
  "type": "crypto",
  "name": "BTC",
  "converterPLN": 88630.02,
  "converterEUR": 18945.46,
  "converterUSD": 19884.8
}
```

### Registration

#### Register new user
```
POST /api/Auth/register
```


Example request body:
```json
{
  "email": "mark.smith@gmail.com",
  "name": "Mark",
  "surname": "Smith",
  "password": "w*3^]GazVt7A8U",
  "currencyPreference": "EUR"
}
```

#### Login
```
POST /api/Auth/login
```


Example request body:
```json
{
  "email": "mark.smith@gmail.com",
  "password": "w*3^]GazVt7A8U"
}
```

#### Change password
```
POST /api/Auth/change
```

Requires authorization: Bearer Token (JWT)

Example request body:
```json
{
  "password": "w*3^]GazVt7A8U"
  "newPassword": "s3*ege7Hd73"
}
```

### User

#### Get Users
```
GET /api/User
```

#### Create new User
```
POST /api/User
```

Example request body:
```json
{
  "email": "mark.smith@gmail.com",
  "name": "Mark",
  "surname": "Smith",
  "password": "s3*ege7Hd73",
  "currencyPreference": "USD"
}
```

#### Delete User
```
DELETE /api/User
```

Requires authorization: Bearer Token (JWT)

#### Change User
```
PATCH /api/User
```
Requires authorization: Bearer Token (JWT)

Example request body:
```json
[
    {
      "value": "Jason",
      "path": "/Name",
      "op": "replace"
    },
    {
      "value": "Cooper",
      "path": "/Surname",
      "op": "replace"
    },
    {
      "value": "PLN",
      "path": "/CurrencyPreference",
      "op": "replace"
    }
    
]
```

#### Get User
```
GET /api/User/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of user |


### UserAsset

#### Get all UserAssets
```
GET /api/UserAsset
```
Requires authorization: Bearer Token (JWT)

#### Create new UserAsset
```
POST /api/UserAsset
```
Requires authorization: Bearer Token (JWT)

Example request body:
```json
{
  "userId": "65a53534-2536-3431-f526-63d5372f6322",
  "assetId": "3fa85f64-5717-4562-b3fc-2c963f66afa9",
  "amount": 12.67
}
```

#### Change UserAsset
```
PUT /api/UserAsset
```
Requires authorization: Bearer Token (JWT)

Example request body:
```json
{
  "userId": "65a53534-2536-3431-f526-63d5372f6322",
  "assetId": "3fa85f64-5717-4562-b3fc-2c963f66afa9",
  "amount": 10
}
```

#### Get UserAsset
```
GET /api/UserAsset/${assetId}
```
Requires authorization: Bearer Token (JWT)

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `assetId`      | `string` | **Required**. Id of asset that userAsset involves|


#### Delete UserAsset
```
DELETE /api/UserAsset/${assetId}
```
Requires authorization: Bearer Token (JWT)

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `assetId`      | `string` | **Required**. Id of asset that userAsset involves|



#### Get total value of all UserAsset
Value is returned in currency chosen by user as a main one (PLN/EUR/USD).
```
DELETE /api/UserAsset/sum
```
Requires authorization: Bearer Token (JWT)



