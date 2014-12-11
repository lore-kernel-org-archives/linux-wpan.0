Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:60799 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933324AbaLKQbe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Dec 2014 11:31:34 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so9261701wid.6
        for <linux-wpan@vger.kernel.org>; Thu, 11 Dec 2014 08:31:32 -0800 (PST)
Date: Thu, 11 Dec 2014 17:31:22 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20141211163116.GA21527@omega>
References: <20141207150814.GA9532@omega>
 <548487CF.4060009@fid4.com>
 <20141207171311.GB9532@omega>
 <20141207171903.GC9532@omega>
 <5484C900.2020402@fid4.com>
 <20141207215452.GB20260@omega>
 <5489B215.20707@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5489B215.20707@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Dec 11, 2014 at 10:02:45AM -0500, Michael C. Cambria wrote:
> 
> On 12/07/2014 04:54 PM, Alexander Aring wrote:
> >
> >ok. Read introductions at [0]. Begin at "Bring up 6LoWPAN" section. For
> >the at86rf230 you should have default a wpan0 interface. If you use
> >wpan-tools simple type "iwpan" and read the help for setting address
> >information. I think for at86rf230 you need to set the panid only, phy
> >settings should be transceiver defaults and short address isn't supported
> >for 6LoWPAN (except broadcast address, of course). The documentation is a
> >little bit outdated currently.
> [deleted]
> >
> >If you need help simple ask here or for better fast live supporting you
> >can contact me via IRC #linux-wpan on irc.freenode.net. Ping between two
> >nodes should be an easy setup. - Alex [0]
> >http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2
> >-- To unsubscribe from this list: send the line "unsubscribe linux-wpan"
> >in the body of a message to majordomo@vger.kernel.org More majordomo info
> >at http://vger.kernel.org/majordomo-info.html
> 
> I'm using bluetooth-next, and it boots and seems to find the openlabs.co
> adapter just fine.
> 
> GettingStarted-0.2 describes the "iz" command.  I don't have "iz".  I
> built/installed on the Pi itself, downloaded from
> http://wpan.cakelab.org/releases/.  I do see an iwpan command installed (see
> below).Are there more user tools or do we just substitute iz with iwpan?
> 
yes, lowpan-tools will be deprecated soon, which means the netlink
interface will be removed... maybe in the next three kernel versions.

> Once an IPv6 address is assigned to wpan0, should I be able to ping wpan0
> from an IPv6 address on a different box?  I ask because I only have one Pi
> at the moment and can't test radio to radio.
> 

No, please forget the complete tutorial with iz.

You need to set a pan_id. "iwpan dev wpan0 set pan_id 0xbeef" or something else
Then create a lowpan interface with:

ip link add link wpan0 name lowpan0 type lowpan

lowpan0 is now your ipv6 interface which use 6LoWPAN.


I will try to make some better new documentation in wpan.cakelab.org
with some asciidoc generated html pages... when I find some time.

- Alex
