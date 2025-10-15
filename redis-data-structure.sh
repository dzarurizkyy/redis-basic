# ===============================
# 📘 Redis Data Structures
# ===============================

# ===============================
# 📜 LISTS
# ===============================
# - Lists are a data structure in the form of a linked list that contains string data.
# - Lists are similar to arrays, where each element in a list has an index number.
# - Common use cases: message queues, task pipelines, and logs.


# ===============================
# 🧭 QUEUE (FIFO)
# ===============================
# - Queue stands for "First In, First Out".
# - The first element added is the first one removed.

## Push value to the left (head) of list
lpush queue value

## Remove and return value from the right (tail)
rpop queue


# ===============================
# 🧱 STACK (LIFO)
# ===============================
# - Stack stands for "Last In, First Out".
# - The last element added is the first one removed.

## Push value to the stack (left side)
lpush stack value

## Pop value from the stack (left side)
lpop stack value

## Get elements from list within range
lrange queue/stack from until


# ===============================
# 🔷 Sets
# ===============================
# - Sets are unordered collections of unique string elements.
# - Duplicate elements are automatically ignored.
# - Common use cases: tags, unique IDs, removing duplicates, etc.

## Add one or more members to a set
sadd key ...value

##  Get the number of members in a set
scard key

## Get all members in a set
smembers key

## Remove one or more members from a set
srem key ...value

## Get the members of the set resulting from the difference between the first set and all the following sets
sdiff key1 key2

## Get the members of the set resulting from the intersection of all the given sets
sinter key1 key2

## Get the members of the set resulting from the union of all the given sets
sunion key1 key2


# ===============================
# 🧩 Hash
# ===============================
# - Hashes are data structures composed of field-value pairs (like a JSON object).
# - Useful for representing objects with multiple properties (e.g., user profiles, products).

## Set field(s) in a hash
hset hashname ...key value

## Get value of a field in a hash
hget hashname key

## Get all fields and values in a hash
hgetall hashname

## Increment or decrement a field value in a hash
hincryby hasname key increment-value/decrement-value


# ===============================
# 🏅 Sorted Set
# ===============================
# - Sorted Sets are similar to Sets but each member has a numeric score.
# - Members are ordered by their score (ascending order).
# - If scores are equal, members are sorted lexicographically.
# - Common use cases: leaderboards, rankings, time-based queues.


## Add a member with a specific score to a sorted set
zadd key score member

## Get the number of members in a sorted set
zcard key

## Get all members and their scores in ascending order
zrange key 0 -1 withscores

## Get members in a sorted set by index range (from lowest to highest score)
zrange key start-index end-index

## Get members in a sorted set by score range (from minimum to maximum score)
zrange key minimum-score maximum-score byscore

## Remove one or more members from a sorted set
zrem key ...member

## Remove members from a sorted set within a specific score range
zremrangebyscore member minimum-score maximum-score


# ===============================
# 📍 Geospatial
# ===============================
# - Geospatial structures are used to store geographic locations as coordinates.
# - Ideal for applications that need distance or radius queries (e.g., finding nearby stores, users, etc.)

## Add location coordinates to a geospatial key
geoadd key longitude latitude member

## Get position (longitude and latitude) of a member
geopos key member

## Get the distance between two members
geodist key member1 member2 distance-unit

## Search for members within a given radius
geosearch key fromlonlat longitude latitude BYRADIUS distance distance-unit


# ===============================
# 🌊 STREAMS
# ===============================
# - Streams are an append-only data structure that works like a log or event stream.
# - Each entry in a stream is a collection of key-value pairs and has a unique ID.
# - Common use cases: event sourcing, message brokers, data pipelines, and activity feeds.

## Add an entry to a stream
xadd stream-name * key value
#   → Adds a new entry with an auto-generated ID ("*" uses current timestamp)

## Read entries from a stream
xread streams stream-name 0
#   → Reads all entries starting from the beginning (ID 0)

## Read entries with a limit (number of messages to read)
xread count value streams stream-name 0
#   → Reads up to 'value' number of entries from the stream, starting from ID 0
#   → Useful when you only want to fetch a limited number of messages at a time

## Block and wait for new entries
xread block 0 streams stream-name last-seen-id
#   → Blocks the connection and waits indefinitely (0 = no timeout) for new entries
#   → Useful for implementing real-time consumers or message listeners
#   → When new data arrives, Redis immediately returns it to the client

## Create a new consumer group for a stream
xgroup create stream-name group-name $ mkstream
#   → Creates a consumer group for the specified stream
#   → '$' means the group will start reading only new entries added after the group is created
#   → 'mkstream' creates the stream automatically if it doesn’t exist

## Create a new consumer within an existing consumer group
xgroup createconsumer stream-name group-name member-group-name
#   → Registers a new consumer (member) inside the given consumer group
#   → Useful when adding multiple consumers that will share the stream workload

## Read messages using a consumer group
xreadgroup group group-name member-group-name count 1 block 0 streams stream-name >
#   → Reads messages as part of the specified consumer group
#   → 'count 1' limits the number of messages fetched at once
#   → 'block 0' waits indefinitely until a new message arrives
#   → '>' means read only messages that have never been delivered to any consumer