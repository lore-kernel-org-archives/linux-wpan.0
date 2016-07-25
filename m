Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48687 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898AbcGYGYc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 02:24:32 -0400
Subject: Re: Packets not reaching lowpan interface
References: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com>
 <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com>
 <1a77b106-bc45-e5da-e122-d4e0713539d8@pengutronix.de>
 <CADaJnMabq8EE11a-18iaQr7yECRKEMKZsBPUbi65Tdk2F==+6A@mail.gmail.com>
 <83c08f12-b506-c377-07ea-0db40f9ec1a0@pengutronix.de>
 <CADaJnMYGk3Lroa=HYuRfAjLg2O9tcVrzHy2JrApHuJ9stuT=Rg@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <55107c60-4525-3c96-a166-096ef6c51970@pengutronix.de>
Date: Mon, 25 Jul 2016 08:24:30 +0200
MIME-Version: 1.0
In-Reply-To: <CADaJnMYGk3Lroa=HYuRfAjLg2O9tcVrzHy2JrApHuJ9stuT=Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aaron Sowry <aeneby@gmail.com>
Cc: linux-wpan@vger.kernel.org


Hi,

On 07/25/2016 02:48 AM, Aaron Sowry wrote:
> Hi,
> 
>>> "If the PAN identifiers are identical, the intra-PAN subfield of the
>>> frame control field shall be set to 1, and the source PAN identifier
>>> shall be omitted from the transmitted frame."
>>>
>>
>> Yes, the question is here if this is valid or not.
> 
> To me it's quite clear given the phrasing quoted above, since the term
> "shall" has a concrete definition[1] in this context:
> 
> "The word 'shall' indicates mandatory requirements strictly to be
> followed in order to conform to the standard and from which no
> deviation is permitted ('shall' equals 'is required to')."
> 
> Ergo, any packet which has identical SRC/DST PANs in its frame must be
> invalid, right?
> 

Oh yes, then it's invalid. I agree. :-)

We should really start some rework of the frame parsing stuff.

>> About the intra-pan check, everybody outside (conitki/RIOT-OS) does
>> intra-pan communication, but I heard that it's possible to change
>> destination pan. So we should do intra-pan communication by default but
>> having some option to change destination pan. Maybe _per_ interface or
>> neighbour, etc?
> 
> I'm also unsure about this. My understanding is that the main (only?)
> purpose of the PAN ID is to reduce MAC overhead by allowing usage of
> the shorter 16-bit addresses, since these addresses should be unique
> within a PAN. Perhaps all intra-pan traffic should really be using
> short addresses? I don't think this is required by the spec but it
> kind of makes sense. I'm not really sure of the details of handling
> intER-pan traffic, I will need to do some research.
> 

You has always the pan given with the short address, in intra-pan and
non intra-pan communication. There is no lack of non uniqueness.

What I see for pan communication is [0].

1.  A destination PAN identifier is included in the frame, and it
    MUST match the PAN ID of the link in question.

I thought this always stands for my link pan-id should be the
destination pan id. But it also could mean that we need to answer on the
destination pan id where the link comes from. E.g. save it as neighbour
attribute in ndisc. I am not sure :-/

- Alex

[0] https://tools.ietf.org/html/rfc4944#section-3
