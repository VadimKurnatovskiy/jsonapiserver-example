
ActiveRecord::Base.transaction do
  bloomsbury = Publisher.create!(name: 'Bloomsbury Publishing', country: 'United Kingdom')
  unwin = Publisher.create!(name: 'George Allen & Unwin', country: 'Australia')
  crime = Publisher.create!(name: 'Collins Crime Club', country: 'United Kingdom')
  mac = Publisher.create!(name: 'Macmillan Publishers', country: 'United Kingdom')

  jk = Author.create!(first_name: 'J.', middle_name: 'K.', last_name: 'Rowling', year_of_birth: 1965)
  tolkien = Author.create!(first_name: 'J.', middle_name: 'R. R.', last_name: 'Tolkien', year_of_birth: 1892)
  agatha = Author.create!(first_name: 'Agatha', last_name: 'Christie', year_of_birth: 1890)
  carroll = Author.create!(first_name: 'Lewis', last_name: 'Carroll', year_of_birth: 1832)

  LOTR = Book.create!(author: tolkien, publisher: unwin, title: 'The Lord of the Rings',
    publication_date: Date.new(1954,8,29), price: 16.99)

  Hobbit = Book.create!(author: tolkien, publisher: unwin, title: 'The Hobbit',
    publication_date: Date.new(1937,9,21), price: 9.99)

  Potter1 = Book.create!(author: jk, publisher: bloomsbury, title: "Harry Potter and the Philosopher's Stone",
    publication_date: Date.new(1997,6,26), price: 8.99)

  Potter2 = Book.create!(author: jk, publisher: bloomsbury, title: "Harry Potter and the Chamber of Secrets",
    publication_date: Date.new(1998,7,2), price: 8.99)

  Potter3 = Book.create!(author: jk, publisher: bloomsbury, title: "Harry Potter and the Prisoner of Azkaban",
    publication_date: Date.new(1999,7,8), price: 5.99)

  Potter4 = Book.create!(author: jk, publisher: bloomsbury, title: "Harry Potter and the Goblet of Fire",
    publication_date: Date.new(2000,7,8), price: 8.99)

  Potter5 = Book.create!(author: jk, publisher: bloomsbury, title: "Harry Potter and the Order of the Phoenix",
    publication_date: Date.new(2003,6,21), price: 7.99)

  Potter6 = Book.create!(author: jk, publisher: bloomsbury, title: "Harry Potter and the Half-Blood Prince",
    publication_date: Date.new(2005,7,16), price: 8.99)

  Potter7 = Book.create!(author: jk, publisher: bloomsbury, title: "Harry Potter and the Deathly Hallows",
    publication_date: Date.new(2007,7,21), price: 8.99)

  Orient = Book.create!(author: agatha, publisher: crime, title: "Murder on the Orient Express",
    publication_date: Date.new(1934,1,1), price: 12.35)

  Ackroyd = Book.create!(author: agatha, publisher: crime, title: "The Murder of Roger Ackroyd",
    publication_date: Date.new(1926,6,1), price: 11.52)

  Vicarage = Book.create!(author: agatha, publisher: crime, title: "The Murder at the Vicarage",
    publication_date: Date.new(1930,10,1), price: 9.98)

  Partners = Book.create!(author: agatha, publisher: crime, title: "Partners in Crime",
    publication_date: Date.new(1929,1,1), price: 7.93)

  ABC = Book.create!(author: agatha, publisher: crime, title: "The A.B.C. Murders",
    publication_date: Date.new(1936,1,6), price: 14.65)

  AndThen = Book.create!(author: agatha, publisher: crime, title: "And Then There Were None",
    publication_date: Date.new(1939,11,6), price: 4.99)

  Alice = Book.create!(author: carroll, publisher: mac, title: "Alice's Adventures in Wonderland",
      publication_date: Date.new(1865,11,26), price: 17.88)

  Glass = Book.create!(author: carroll, publisher: mac, title: "Through the Looking-Glass",
    publication_date: Date.new(1871,1,1), price: 16.30)

  [["Renata", "Ruhl", "Barcelona"], ["Hellen", "Herrera", "Cupertino"], ["Antoine", "Augustin", "San Jose"],
  ["Sage", "Sater", "Saratoga"], ["Avery", "Artman", "San Francisco"], ["Crystle", "Crispin", "Madrid"],
  ["Bobette", "Bormann", "Barcelona"], ["Gayla", "Gearheart", "Cupertino"], ["Leslee", "Lett", "Santa Clara"],
  ["Raul", "Rippy", "Santa Clara"], ["Antonia", "Allie", "San Jose"], ["Julienne", "Jelinek", "Barcelona"],
  ["Vernon", "Vanegas", "Cupertino"], ["Sarai", "Scher", "Santa Cruz"], ["Santiago", "Stoner", "Santa Cruz"],
  ["Kandra", "Krupa", "Madrid"], ["Vennie", "Valenzuela", "Manchester"], ["Un", "Ursery", "London"],
  ["Diego", "Daggett", "San Francisco"], ["Fredrick", "Filler", "San Jose"]]
  .each do |val|
    Patron.create!(first_name: val[0], last_name: val[1], city: val[2])
  end

  [
    %q[Although the whole of this life were said to be nothing but a dream and the physical
      ruby muworld nothing but a phantasm, I should call this dream or phantasm real enough,
      if, using reason well, we were never deceived by it.],
    %q[The only thing I regret about my past is the length of it. If I had to live my
       life again, I'd make the same mistakes, only sooner.],
    %q[A man may be in as just possession of truth as of a city, and yet be forced to surrender.],
    %q[She is all states, and all princes, I, Nothing else is.],
    %q[Those who believe that they are exclusively in the right are generally those who achieve something.],
    %q[The worst speak something good; if all want sense, God takes a text, and preacheth Patience.],
    %q[The hardest people to convince they are at retirement age are children at bedtime.],
    %q[RECREATION, n. A particular kind of dejection to relieve a general fatigue.],
    %q[Things are more like they are now than they ever were before.],
    %q[It is always right that a man should be able to render a reason for the faith that is within him.],
    %q[Technological man can't believe in anything that can't be measured, taped, or put into a computer.],
    %q[Luke: The Force? Ben: Now, the Force is what gives a Jedi his power. It's an energy field
      created by all living things. It surrounds us, it penetrates us, it binds the galaxy together.],
    %q[Few people think more than two or three times a year. I have made an international
      reputation for myself by thinking once or twice a week.],
    %q[Winning is nice if you don't lose your integrity in the process.],
    %q[Stretch your vision. See what can be, not just what is. Practice adding value to things, to people and to yourself.],
    %q[Speak not against anyone whose burden you have not weighed yourself.],
    %q[Ability will never catch up with the demand for it.],
    %q[One good thing about being young is that you are not experienced enough to know you
      cannot possibly do the things you are doing.],
    %q[A Robin Redbreast in a cage Puts all Heaven in a Rage.],
    %q[If only we could learn that tolerance is the oil that takes the friction out of life!],
    %q[Hunting ... the least honorable form of war on the weak.],
    %q[Happiness is beneficial for the body, but it is grief that develops the powers of the mind.],
    %q[If I had my life to live over again, I don't think I would have the strength.],
    %q[Slow down and everything you are chasing will come around and catch you.],
    %q[Successful people are the ones who can think up stuff for the rest of the world to keep busy at.]
  ].each do |quote|
    Comment.create!(book: Book.random, patron: Patron.random, text: quote)
  end

  (1..30).each do
    Checkout.create!(book: Book.random, patron: Patron.random, checkout_date: Date.today-rand(10000))
  end
end
