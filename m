Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44000 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752039AbcGXUuB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sun, 24 Jul 2016 16:50:01 -0400
Subject: Re: Packets not reaching lowpan interface
References: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com>
 <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
 <1a77b106-bc45-e5da-e122-d4e0713539d8@pengutronix.de>
 <CADaJnMabq8EE11a-18iaQr7yECRKEMKZsBPUbi65Tdk2F==+6A@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <83c08f12-b506-c377-07ea-0db40f9ec1a0@pengutronix.de>
Date: Sun, 24 Jul 2016 22:49:58 +0200
MIME-Version: 1.0
In-Reply-To: <CADaJnMabq8EE11a-18iaQr7yECRKEMKZsBPUbi65Tdk2F==+6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aaron Sowry <aeneby@gmail.com>
Cc: linux-wpan@vger.kernel.org


Hi,

On 07/24/2016 10:32 PM, Aaron Sowry wrote:
> Hi Alex
> 
> 2016-07-24 22:03 GMT+12:00 Alexander Aring <aar@pengutronix.de>:
>>
>> I don't know which version on RIOT does this behaviour, we should open
>> an issue at github RIOT-OS project if this issue still exists. Please
>> check if you seeing on wireshark that it is intra pan communication but
>> the intra pan id bit isn't set.
> 
> You're absolutely right - both SRC and DST PANs are being put in the
> header by RIOT, and the intra-pan bit set to 0, even though the PANs
> are the same. If I cook the packet slightly so it is properly
> constructed before sending, everything starts working fine.
> 
>> Another chance to fix this issue is to backport [0] and some other
>> patches to get it working.
> 
> Actually, I don't think the intra-pan packets currently being sent out
> by RIOT are valid 802.15.4. From the spec (page 154):
> 
> "If the PAN identifiers are identical, the intra-PAN subfield of the
> frame control field shall be set to 1, and the source PAN identifier
> shall be omitted from the transmitted frame."
> 

Yes, the question is here if this is valid or not. We came to the
decisison it's a valid frame but not efficiency if somebody does so.

If somebody knows more if this frame is valid or not then I would
be interested to handle this right.

Anyway if frame is valid or not, this need to be handled in a layer before.

> So IMO this is a bug in RIOT - whether or not Linux should handle this
> type of packet anyway is a matter of opinion, I guess.
> 

Yea, RIOT should not sending such frames.

About the intra-pan check, everybody outside (conitki/RIOT-OS) does
intra-pan communication, but I heard that it's possible to change
destination pan. So we should do intra-pan communication by default but
having some option to change destination pan. Maybe _per_ interface or
neighbour, etc?

Per neighbour sounds reasonable for me, but then we need to do the
broadcasting frames as well on dst_pan 0xffff.

I currently have no idea how it's specified, maybe:

 - broadcast do on dst_pan 0xffff.
 - they see the source pan_id, the ndisc cache will save to responds to
   xxx neighbour at dst_pan yyyy.

I need to look into that to see if this really working, but the RFC is
very unclear how to deal with pans. We adapt that what all others do
currently. But I think the above solution is better and maybe ?right?

>> We should really open a issue on that, that this is broken @RIOT-OS git
>> version. Maybe somebody can bisect it? To get the broken commit id.
> 
> https://github.com/RIOT-OS/RIOT/issues/5684
> 

Thank you.

- Alex
