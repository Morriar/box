# Box

A tool to submit and check student assignments.

<table>
	<tr>
		<td><img src='https://raw.githubusercontent.com/Morriar/box/master/doc/example1.png'></td>
		<td><img src='https://raw.githubusercontent.com/Morriar/box/master/doc/example2.png'></td>
	</tr>
</table>

## Building

Run in console:

~~~bash
make
~~~

## Configuring

See the `app.ini` file to configure the popcorn app:

* `app.host`: app hostname
* `app.port`: app port
* `app.root_url`: used for redirect/call back from 3rd-party authentications.
  To use if behind a reverse proxy or if host is 0.0.0.0

## Running the web interface

Run in console:

~~~bash
make web
~~~

## Using with command line

See `boxes/README.md` for the complete documentation of the command line tools.

## Contributing

The `Box` team is happy to receive contributions and suggestions.
Give a look at the Github repo
[https://github.com/Morriar/box](https://github.com/Morriar/box).
