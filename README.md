# README

This app demonstrates the use of the JsonApiServer gem https://github.com/ed-mare/json_api_server. It is a Rails 5.1.x app which is known to work with Ruby 2.4.1. It uses sqlite and is configured for file-based caching.

**Run this app in development environment only.**

## Setup

Checkout this repository, `cd` to the root of the app and run:

```shell
# install gems
bundle install

# create database and seed it
rake db:migrate
rake db:seed

# start server
bundle exec rails s -p 3000
```

If using docker:

```shell
# Docker image known to work on Ubuntu 14.04 and 16.04 with docker 1.3.1+

# build the web image
docker-compose build

# start bash session and run tasks to build/seed database
docker-compose run --rm web /bin/bash
rake db:migrate
rake db:seed

# start the server
docker-compose up
```

## Cleanup

Cleanup file cache:

```shell
# cd to root of app
rm -rf tmp/file_store_cache/*
```

## Notes

#### Limitations

- Filters can only be applied to the parent resource, however, model queries and custom builders can perform joins, etc. to query associations.
- Sort can only be applied to the parent resource.
- Nested `included` sections are not bubbled up to the parent `included` section.

#### Error Handling

Error handling module is included in `controllers/applicaiton_controller.rb`.

#### Locales

'config/locales/en.yml' customizes errors messages.

#### Mime types

application/vnd.api+json is configured in `config/initializers/mime_types.rb`

#### Configurations

Configurations are in `config/initializers/json_api_server.rb`

```shell
config.active_support.escape_html_entities_in_json = false
```

...is added to application.rb so pagination URLs aren't escaped. This is an OJ/Rails compatibility configuration:
https://github.com/ohler55/oj/blob/master/pages/Rails.md

#### Serializers

Serializers are in `app/serializers` folder.

#### Includes, Filter, Sort, Pagination Configurations

Includes, filter, sort, and pagination configurations are in the controllers.

## Examples

#### Eager loading related resources

The publishers controller demonstrates eager loading related resources (includes).

```shell
# relationships 2 levels deep - publisher books and book author
http://localhost:3000/api/v1/publishers?include=publisher.books,book.author&fields[books]=title&fields[authors]=first_name,last_name
```
It performs queries like...

```shell
SELECT  "publishers".* FROM "publishers" ORDER BY "publishers"."id" DESC LIMIT ? OFFSET ?  [["LIMIT", 10], ["OFFSET", 0]]
SELECT "books".* FROM "books" WHERE "books"."publisher_id" IN (5, 4, 3, 2, 1)
SELECT "authors".* FROM "authors" WHERE "authors"."id" IN (5, 4, 3, 2, 1)
```

Each publisher looks something like...

```json
{
  "type": "publishers",
  "id": 2,
  "attributes": {
    "name": "George Allen & Unwin",
    "country": "Australia",
    "created": "2017-09-19T02:28:24Z",
    "updated": "2017-09-19T02:28:24Z"
  },
  "relationships": {
    "books": [
      {
        "data": {
          "type": "books",
          "id": 1,
          "attributes": {
            "title": "The Lord of the Rings"
          },
          "relationships": {
            "author": {
              "data": {
                "type": "authors",
                "id": 2,
                "attributes": {
                  "first_name": "J.",
                  "last_name": "Tolkien"
                },
                "relationships": {}
              }
            }
          }
        }
      },
      {
        "data": {
          "type": "books",
          "id": 2,
          "attributes": {
            "title": "The Hobbit"
          },
          "relationships": {
            "author": {
              "data": {
                "type": "authors",
                "id": 2,
                "attributes": {
                  "first_name": "J.",
                  "last_name": "Tolkien"
                },
                "relationships": {}
              }
            }
          }
        }
      }
    ]
  }
}
```

#### Low level caching of related resources

The books controller demonstrates low level caching of related resources.

```shell
http://localhost:3000/api/v1/books?include=book.checkouts,book.comments,comment.patron,checkout.patron&fields[books]=title&fields[comments]=text&fields[patrons]=first_name,last_name&fields[checkouts]=checkout_date
```

After caching for the first time, it performs queries like...

```shell
SELECT COUNT(*) FROM "books"
SELECT  "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT ? OFFSET ?  [["LIMIT", 10], ["OFFSET", 0]]
```

Each book should look something like...

```shell
{
  "type": "books",
  "id": 17,
  "attributes": {
    "title": "Through the Looking-Glass"
  },
  "relationships": {
    "comments": [
      {
        "data": {
          "type": "comments",
          "id": 18,
          "attributes": {
            "text": "One good thing about being young is that you are not experienced enough to know you\n      cannot possibly do the things you are doing."
          },
          "relationships": {
            "patron": {
              "data": {
                "type": "patrons",
                "id": 8,
                "attributes": {
                  "first_name": "Gayla",
                  "last_name": "Gearheart"
                },
                "relationships": {}
              }
            }
          }
        }
      },
      {
        "data": {
          "type": "comments",
          "id": 15,
          "attributes": {
            "text": "Stretch your vision. See what can be, not just what is. Practice adding value to things, to people and to yourself."
          },
          "relationships": {
            "patron": {
              "data": {
                "type": "patrons",
                "id": 18,
                "attributes": {
                  "first_name": "Un",
                  "last_name": "Ursery"
                },
                "relationships": {}
              }
            }
          }
        }
      },
      {
        "data": {
          "type": "comments",
          "id": 6,
          "attributes": {
            "text": "The worst speak something good; if all want sense, God takes a text, and preacheth Patience."
          },
          "relationships": {
            "patron": {
              "data": {
                "type": "patrons",
                "id": 17,
                "attributes": {
                  "first_name": "Vennie",
                  "last_name": "Valenzuela"
                },
                "relationships": {}
              }
            }
          }
        }
      },
      {
        "data": {
          "type": "comments",
          "id": 5,
          "attributes": {
            "text": "Those who believe that they are exclusively in the right are generally those who achieve something."
          },
          "relationships": {
            "patron": {
              "data": {
                "type": "patrons",
                "id": 20,
                "attributes": {
                  "first_name": "Fredrick",
                  "last_name": "Filler"
                },
                "relationships": {}
              }
            }
          }
        }
      },
      {
        "data": {
          "type": "comments",
          "id": 1,
          "attributes": {
            "text": "Although the whole of this life were said to be nothing but a dream and the physical\n      ruby muworld nothing but a phantasm, I should call this dream or phantasm real enough,\n      if, using reason well, we were never deceived by it."
          },
          "relationships": {
            "patron": {
              "data": {
                "type": "patrons",
                "id": 20,
                "attributes": {
                  "first_name": "Fredrick",
                  "last_name": "Filler"
                },
                "relationships": {}
              }
            }
          }
        }
      }
    ],
    "checkouts": {
      "data": {
        "type": "checkouts",
        "id": 8,
        "attributes": {
          "checkout_date": "2003-11-25"
        },
        "relationships": {
          "patron": {
            "data": {
              "type": "patrons",
              "id": 15,
              "attributes": {
                "first_name": "Santiago",
                "last_name": "Stoner"
              },
              "relationships": {}
            }
          }
        }
      }
    }
  }
},
```

#### Example of search against model query

The custom model query does a wildcard query against author first_name OR last_name.

```
http://localhost:3000/api/v1/books?filter[author]=christie
```

#### Example of range search between two dates using operators (< and >)

```shell
http://localhost:3000/api/v1/books?include=book.publisher,book.comments&filter[published]=>2000-01-01&filter[published1]=<2016-01-01
```

#### Example of IN query (values separated by commas)

```shell
http://localhost:3000/api/v1/books?filter[author_id]=1,2,3
```

Should return something like...

```json
{
  "jsonapi": {
    "version": "1.0"
  },
  "links": {
    "first": "http://localhost:3000/api/v1/books?fields%5Bbooks%5D=title%2Cauthor_id&filter%5Bauthor_id%5D=1%2C2%2C3&page%5Blimit%5D=20&page%5Bnumber%5D=1&sort=author_id",
    "last": "http://localhost:3000/api/v1/books?fields%5Bbooks%5D=title%2Cauthor_id&filter%5Bauthor_id%5D=1%2C2%2C3&page%5Blimit%5D=20&page%5Bnumber%5D=1&sort=author_id",
    "self": "http://localhost:3000/api/v1/books?fields%5Bbooks%5D=title%2Cauthor_id&filter%5Bauthor_id%5D=1%2C2%2C3&page%5Blimit%5D=20&page%5Bnumber%5D=1&sort=author_id",
    "next": null,
    "prev": null
  },
  "data": [
    {
      "type": "books",
      "id": 3,
      "attributes": {
        "title": "Harry Potter and the Philosopher's Stone",
        "author_id": 1
      }
    },
    {
      "type": "books",
      "id": 4,
      "attributes": {
        "title": "Harry Potter and the Chamber of Secrets",
        "author_id": 1
      }
    },
    {
      "type": "books",
      "id": 5,
      "attributes": {
        "title": "Harry Potter and the Prisoner of Azkaban",
        "author_id": 1
      }
    },
    {
      "type": "books",
      "id": 6,
      "attributes": {
        "title": "Harry Potter and the Goblet of Fire",
        "author_id": 1
      }
    },
    {
      "type": "books",
      "id": 7,
      "attributes": {
        "title": "Harry Potter and the Order of the Phoenix",
        "author_id": 1
      }
    },
    {
      "type": "books",
      "id": 8,
      "attributes": {
        "title": "Harry Potter and the Half-Blood Prince",
        "author_id": 1
      }
    },
    {
      "type": "books",
      "id": 9,
      "attributes": {
        "title": "Harry Potter and the Deathly Hallows",
        "author_id": 1
      }
    },
    {
      "type": "books",
      "id": 1,
      "attributes": {
        "title": "The Lord of the Rings",
        "author_id": 2
      }
    },
    {
      "type": "books",
      "id": 2,
      "attributes": {
        "title": "The Hobbit",
        "author_id": 2
      }
    },
    {
      "type": "books",
      "id": 10,
      "attributes": {
        "title": "Murder on the Orient Express",
        "author_id": 3
      }
    },
    {
      "type": "books",
      "id": 11,
      "attributes": {
        "title": "The Murder of Roger Ackroyd",
        "author_id": 3
      }
    },
    {
      "type": "books",
      "id": 12,
      "attributes": {
        "title": "The Murder at the Vicarage",
        "author_id": 3
      }
    },
    {
      "type": "books",
      "id": 13,
      "attributes": {
        "title": "Partners in Crime",
        "author_id": 3
      }
    },
    {
      "type": "books",
      "id": 14,
      "attributes": {
        "title": "The A.B.C. Murders",
        "author_id": 3
      }
    },
    {
      "type": "books",
      "id": 15,
      "attributes": {
        "title": "And Then There Were None",
        "author_id": 3
      }
    }
  ],
  "included": [],
  "meta": null
}
```

#### Example of wildcard query

```shell
http://localhost:3000/api/v1/books?filter[title]=*murder&fields[books]=title
```

Should return something like...

```json
{
  "jsonapi": {
    "version": "1.0"
  },
  "links": {
    "first": "http://localhost:3000/api/v1/books?fields%5Bbooks%5D=title&filter%5Btitle%5D=%2Amurder&page%5Blimit%5D=10&page%5Bnumber%5D=1",
    "last": "http://localhost:3000/api/v1/books?fields%5Bbooks%5D=title&filter%5Btitle%5D=%2Amurder&page%5Blimit%5D=10&page%5Bnumber%5D=1",
    "self": "http://localhost:3000/api/v1/books?fields%5Bbooks%5D=title&filter%5Btitle%5D=%2Amurder&page%5Blimit%5D=10&page%5Bnumber%5D=1",
    "next": null,
    "prev": null
  },
  "data": [
    {
      "type": "books",
      "id": 14,
      "attributes": {
        "title": "The A.B.C. Murders"
      }
    },
    {
      "type": "books",
      "id": 12,
      "attributes": {
        "title": "The Murder at the Vicarage"
      }
    },
    {
      "type": "books",
      "id": 11,
      "attributes": {
        "title": "The Murder of Roger Ackroyd"
      }
    },
    {
      "type": "books",
      "id": 10,
      "attributes": {
        "title": "Murder on the Orient Express"
      }
    }
  ],
  "included": [],
  "meta": null
}
```

#### Example posting a new book with author and publisher relationships

Note: the request returns requested inclusions on success.

```shell
cd ./examples_json
curl -vX POST http://localhost:3000/api/v1/books?include=book.author,book.publisher -d @new_book.json --header "Content-Type: application/vnd.api+json"
```

First time should return:

```json
{
  "jsonapi": {
    "version": "1.0"
  },
  "links": {
    "self": "http://localhost:3000/api/v1/books/1"
  },
  "data": {
    "type": "books",
    "id": 1,
    "attributes": {
      "title": "An entry added programmatically 1",
      "description": "A fake book",
      "publication_date": "2015-05-22",
      "price": 5.56,
      "publisher_id": 1,
      "author_id": 1,
      "created": "2017-09-19T02:09:47Z",
      "updated": "2017-09-19T02:09:47Z"
    },
    "relationships": {
      "author": {
        "data": {
          "type": "authors",
          "id": 1,
          "attributes": {
            "first_name": "John",
            "middle_name": null,
            "last_name": "Doe I",
            "year_of_birth": 1976,
            "created": "2017-09-19T02:09:47Z",
            "updated": "2017-09-19T02:09:47Z"
          },
          "relationships": {}
        }
      },
      "publisher": {
        "data": {
          "type": "publishers",
          "id": 1,
          "attributes": {
            "name": "FooBar Publishers",
            "country": "USA",
            "created": "2017-09-19T02:09:47Z",
            "updated": "2017-09-19T02:09:47Z"
          },
          "relationships": {}
        }
      }
    }
  },
  "included": [],
  "meta": null
}
```

Run it again and it should return (unique index constraint):

```json
{
  "jsonapi": {
    "version": "1.0"
  },
  "errors": [
    {
      "status": 409,
      "title": "Conflict",
      "detail": "This book already exists."
    }
  ]
}
```

#### Example posting with validation error response

```shell
curl -vX POST http://localhost:3000/api/v1/books?include=book.author,book.publisher -d @new_book_validation_error.json --header "Content-Type: application/vnd.api+json"
```

Should return something like...

```json
{
  "jsonapi": {
    "version": "1.0"
  },
  "errors": [
    {
      "status": "422",
      "source": {
        "pointer": "/data/attributes/title"
      },
      "title": "Invalid Attribute",
      "detail": "Title can't be blank"
    }
  ]
}
```
