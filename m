Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35695 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbcCHIWQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 8 Mar 2016 03:22:16 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so119871362wml.0
        for <linux-wpan@vger.kernel.org>; Tue, 08 Mar 2016 00:22:15 -0800 (PST)
Date: Tue, 8 Mar 2016 09:22:08 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [6lo] big frame support in 802.15.4G
Message-ID: <20160308082207.GA790@omega>
References: <20160228140659.GA17980@omega>
 <28981.1457015214@obiwan.sandelman.ca>
 <20160304083528.GA1525@omega>
 <24416.1457106776@obiwan.sandelman.ca>
 <20160304163749.GA21798@omega>
 <18168.1457123400@obiwan.sandelman.ca>
 <56DC2A0A.6070906@htt-consult.com>
 <4538.1457367913@obiwan.sandelman.ca>
 <D302EF45.3625F%d.sturek@att.net>
 <56DDED58.5060500@htt-consult.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56DDED58.5060500@htt-consult.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Robert Moskowitz <rgm-ietf@htt-consult.com>
Cc: Don Sturek <d.sturek@att.net>, Michael Richardson <mcr+ietf@sandelman.ca>, linux-wpan@vger.kernel.org, 6lo@ietf.org

Hi,

On Mon, Mar 07, 2016 at 04:06:32PM -0500, Robert Moskowitz wrote:
> I was thinking that there is also some difference in the physical header to
> support the larger PPU?
> 

I copy&paste here some parts which I already wrote in another mailing
thread:

---
Looking again into 802.15.4g-2012 there stands on page (not pdf page)
95:

"For the 780 MHz, 915 MHz, and 2450 MHz frequency bands, the MR-O-QPSK
 PHY supports communication with legacy devices according to the
 specifications in Clause 10, as described in 18.3.3."

so somewhat with "Clause 10" and at 18.3.3 the standard says:

"18.3.3 Support of legacy devices of the 780 MHz, 915 MHz, and 2450 MHz
 O-QPSK PHYs" ... the lot of copy&pasting witht the same sentences but
 different frequencies. :-)

Then looking into 802.15.4-2011 for Clause 10, the standard says:

"10. O-QPSK PHY"

so Clause 10, they mean all other PHYs. For me it looks like it is
possible to communicate with "legacy device according to the
specifications in Clause 10".
---

That means for me:

MR-O-QPSK is compatible with O-QPSK.

The question which follows is:
How 6LoWPAN for 802.15.4g devices deals with 802.15.4g and 802.15.4-2011
(legacy devices) in one 6LoWPAN network, if this handling is supported
somehow?

Is there some mechanism on for getting the capabilities "MTU" and
Modulation for each neighbor?

Then you could start always with a O-QPSK modulation and 127 bytes MTU,
if you know your 6LoWPAN network is a complete 802.15.4g only network,
then simple use 802.15.4g features.

If not: exist there some mechanism (Option-Field in NA) to see, this
neighbor is a SUN Phy and I could change the MTU/modulation for this
neighbor.

btw: for broadcast frames you should need then 127 bytes and O-QPSK
only.

- Alex
