Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from nm6-vm6.access.bullet.mail.gq1.yahoo.com ([216.39.63.154]:32860
	"EHLO nm6-vm6.access.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813AbcCGQ7n (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Mar 2016 11:59:43 -0500
Date: Mon, 07 Mar 2016 08:53:28 -0800
Subject: Re: [6lo] big frame support in 802.15.4G
From: Don Sturek <d.sturek@att.net>
Message-ID: <D302EF45.3625F%d.sturek@att.net>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
 <20160228140659.GA17980@omega>
 <28981.1457015214@obiwan.sandelman.ca>
 <20160304083528.GA1525@omega>
 <24416.1457106776@obiwan.sandelman.ca>
 <20160304163749.GA21798@omega>
 <18168.1457123400@obiwan.sandelman.ca>
 <56DC2A0A.6070906@htt-consult.com>
 <4538.1457367913@obiwan.sandelman.ca>
In-Reply-To: <4538.1457367913@obiwan.sandelman.ca>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr+ietf@sandelman.ca>, Robert Moskowitz <rgm-ietf@htt-consult.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, 6lo@ietf.org

Hi Michael,

I was not clear on what you were asking.  Here are a couple of points:
1)  IEEE 802.15.4g was an amendment to IEEE 802.15.4-2011 where the main
contributions were to the PHY (not so much the MAC).   There is nothing in
4g that would make it incompatible with IEEE 802.15.4-2011
2)  IEEE 802.15.4-2011 has a field called "frame version" that denotes
special processing for the 2003, 2006 and 2011 versions of the
specification.  That is one place where a packet may be dropped but that
would not apply to MAC versions that are based on 2011 alone
3)  If you were asking whether a 4g MAC/PHY implementation could send
payloads of varying sizes then I think the answer is "yes" with the
following caveats:
      I.     Since IEEE 802.15.4 never had a propoer protocol dispatch
until IEEE 802.15.9 came along, there would have to be some special vendor
extensions to denote where a full IPv6 frame was present or when a 6LoWPAN
fragment was present.  It is possible with the Multiplex ID/EtherType in
IEEE 802.15.9 to make that distinction.

I think in some implementations you would see a varying payload size.  For
example, when transferring packets over a good radio link, the payload
size might be set to 1280 bytes or better and a full IPv6 frame would be
present.  In cases where the link is poor, the two communicating devices
may choose to use shorter packets and 6LoWPAN to fragment/reassemble,
however, keep in mind there are only MAC retries to ensure delivery.

Don




On 3/7/16 8:25 AM, "6lo on behalf of Michael Richardson"
<6lo-bounces@ietf.org on behalf of mcr+ietf@sandelman.ca> wrote:

>
>Robert Moskowitz <rgm-ietf@htt-consult.com> wrote:
>    > The difference is in the header bits. A 802.15.4-2011 device would
>see
>    > the bits set in the header that 4g uses and drop the packet
>    > immediately. Pat would have to pipe in here, and there may be some
>    > issues around super frames and intergap timings that result in
>    > interesting behaviour, better to be avoided.
>
>Right, but the question is:
>
>1) is it physically possible for a 15.4g device to send both 15.4g
>   frames and 15.4-2011 frames?
>   Another email suggests that this can never happen because frequencies
>   are never the same.  If so, end of problem.
>
>2) if the answer to question 1 is yes, then 15.4g devices need to know
>   if they are speaking to 15.4-2011 devices, and
>      a) adjust their frame header bits appropriately.
>      b) to 6lowpan fraglettation.
>
>
>--
>Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
> -= IPv6 IoT consulting =-
>
>
>
>_______________________________________________
>6lo mailing list
>6lo@ietf.org
>https://www.ietf.org/mailman/listinfo/6lo


