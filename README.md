# README

## Get Tenant with fields 
GET http://localhost:3000/tenants/{id}

## Create Tenant
POST http://localhost:3000/tenants/
{
    "first_name": "Lora",
    "last_name": "Hart",
    "email": "hart@gmail.com",
    "fields_attributes": [
        {
            "name": "nickname",
            "type": "StringField"
        },
        {
            "name": "levels",
            "type": "MultipleChoice",
            "data": ["1", "2", "3"]
        }
    ]
}

## Update Tenant
PATCH http://localhost:3000/tenants/{id}
{
    "fields_attributes": [
        {
            "name": "price",
            "type": "NumberField"
        }
    ]
}


## Get User
http://localhost:3000/users/{id}

## Create User
POST http://localhost:3000/users/
{
    "first_name": "Lex",
    "last_name": "Morgan",
    "email": "morgan@gmail.com",
    "tenant_id": {id}
}

## Update User with custom fields
PATCH http://localhost:3000/users/{id}
{
    "nickname": "Oktagon",
    "price": 123,
    "levels": [ "1", "2" ]
}


