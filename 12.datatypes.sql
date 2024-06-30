/* Types of Data types in postgresql
- Numbers:
    [Numbers without any decimal points]
    smallint -> -32768 to +32767
    integer -> -2147583648 to 2174483647
    bigint -> -9223372036854775808 to 9223372036854775807

    [Numbers without any decimal points and auto increment]
    smallserial -> 1 to 32767
    serial -> 1 to 2147483647
    bigserial -> 1 to 9223372036854775807

    [Numbers with decimal points]
    [With Precision]
    decimal -> 131072 digits before decimal points, 16383 after
    numeric -> 131072 digits before decimal points, 16383 after.

    [Without Precision]
    real -> 1E-37 to 1E37 with at least 6 places precision
    double precision -> 1E-307 to 1E308 with at least 15 place precision
    float -> same as real or double precision

    [FAST RULES]
    'id' column of any table -> serial
    Need to store a number without a decimal -> integer
    Need to store a number with a decimal and this data needs to be very
    accurate like bank balance, grams of gold, scientific calculations -> numeric
    Need to store a number with a decimal and the decimal doesn't make a
    big difference like kilograms of trash in a landfill, liters of water in a
    lake, air pressure in a tire -> double precision.

- Character
    CHAR(5) -> Store some characters, length will always be 5 even if postgres
    has to insert spaces.

    VARCHAR -> Store any length of string

    VARCHAR(40) -> Store a string up to 40 characters, automatically remove extra
    characters.

    TEXT -> Store any length of string.

    [NOTE: No performance difference b/w all character types]

- Boolean
    Supports -> TRUE, FALSE, NULL

    Convert automatically by postgres
    true, 'yes', 'on', 1, 't', 'y' -> TRUE
    false, 'no', 'off', 0, 'f', 'n' -> FALSE
    null -> NULL

- Date/Time
    valid input DATE formats plus more
    1980-11-20 -> 20 November 1980
    Nov-20-1980 -> 20 November 1980
    20-Nov-1980 -> 20 November 1980
    1980-November-20 -> 20 November 1980
    November 20, 1980 -> 20 November 1980

    TIME
    TIME WITHOUT TIME ZONE
    01:23 AM -> 01:23, no time
    05:23 PM -> 17:23, no time zone
    20:34 -> 20:34, no time zone

    TIME WITH TIME ZONE
    01:23 AM EST -> 01:23-05:00
    05:23 PM PST -> 17:23-08:00
    05:23 PM UTC -> 17:23+00:00
    05:23 PM UTC -> 17:23+00:00

    TIMESTAMP WITH TIME ZONE
    SELECT ('Nov-20-1980 1:23 AM PST')
    SELECT ('Nov-20-1980 1:23 AM PST'::TIMESTAMP WITH TIME ZONE);

    INTERVAL
    1 day -> 1 day
    1 D -> 1 day
    1 D 1 M 1 S -> 1 day 1 minute 1 second

    Think of an interval as a duration of time.



- Geometric
- Currency
- Range
- XML
- Binary
- JSON
- Arrays
- UUID
*/

SELECT (2 + 2); -- return 2, column type is integer

SELECT (2.0); -- return 2.0, column type is numeric

SELECT (2.0::INTEGER); -- return 2, column type is integer. This is type conversion

SELECT (1.99999::REAL - 1.99998::REAL); -- return 1.001358e-05 ; Floating point approximation.

SELECT (1.99999::NUMERIC - 1.99998::NUMERIC); -- return 0.00001 ; Actual value

-- REAL, Double precision, Float is efficient in terms of calculation but not accurate.
-- DECIMAL, NUMERIC is not that efficient in terms of calculation but accurate.


-- WE can do mathematical operation also.
SELECT ('1 D 20 H 30 M 45S'::INTERVAL) - ('1 D'::INTERVAL);
-- Output => 20:30:45

SELECT ('NOV-20-1980 1:23 AM EST'::TIMESTAMP WITH TIME ZONE) - ('4 D'::INTERVAL)
-- Output => 1980-11-16 11:53+05:30

SELECT ('NOV-20-1980 1:23 AM EST'::TIMESTAMP WITH TIME ZONE) - ('NOV-10-1980 1:23 AM EST'::TIMESTAMP WITH TIME ZONE)
-- Output => 10 days

-- Different timezone difference
SELECT ('NOV-20-1980 1:23 AM PST'::TIMESTAMP WITH TIME ZONE) - ('NOV-10-1980 1:23 AM EST'::TIMESTAMP WITH TIME ZONE)
-- Output => 10 days 3 hours

