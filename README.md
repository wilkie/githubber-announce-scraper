# Githubber Announce Scraper

This project pulls the github blog rss and rakes it for githubber announcements. It then pulls some information and determines if certain keywords are in the blerb. It organizes this information in several formats and includes a query tool to browse the information.

## Why

This tool and information can be used to determine if diversity is met at an influential company. No assumptions can really be made, however, since a company like github is widely known and visible in the community, it offers a great opportunity for a case study to look at how visible the community is to that company. Keywords are pulled at my discretion to look for what role the individual plays in the company and what gender they identify with (through pronoun usage). Any results or interpretations should be made with care. All text is also published and should be used to determine the symantics of the keywords used.

## Tools

    USAGE : (select output option)
      ./pull.rb [--markdown | --json | --html | --flat ]

This tool will pull down the rss and output the result in the given format.

    USAGE:"
      ./poll.rb --name <PARTIAL NAME TO MATCH>
      ./poll.rb --any-tags <TAG> <TAG>? ...
      ./poll.rb --all-tags <TAG> <TAG>? ...

This tool will use the json output (make sure it is there) to perform simply queries for quick browsing.

## Output

I have included output in all formats so you don't have to hit github's servers or if they become unavailable. These data was available on the date of the commit that added them.
