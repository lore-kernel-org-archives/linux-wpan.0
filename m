Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:38568 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaIWHTl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 03:19:41 -0400
Received: by mail-we0-f171.google.com with SMTP id k48so4078551wev.2
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 00:19:40 -0700 (PDT)
Date: Tue, 23 Sep 2014 09:19:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
Message-ID: <20140923071932.GA11396@omega>
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com>
 <20140916070156.GB1244@omega>
 <541899D8.4020101@componentsw.com>
 <20140916202000.GF6104@omega>
 <5420EE4F.5000007@signal11.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5420EE4F.5000007@signal11.us>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Ott <alan@signal11.us>
Cc: Walter Mack <wmack@componentsw.com>, linux-wpan@vger.kernel.org, simon.vincent@xsilon.com

Hi,

On Mon, Sep 22, 2014 at 11:51:43PM -0400, Alan Ott wrote:
> On 09/16/2014 04:20 PM, Alexander Aring wrote:
> >Hi Walter,
> >
> >On Tue, Sep 16, 2014 at 01:13:12PM -0700, Walter Mack wrote:
> >>Alex,
> >>
> >>this is not a question of chip revisions. Chips with the same revision can
> >>be used in designs with or without the external transmitter/receiver. Its
> >>just that the chip has to be set up to be compatible with the design.
> >>
> >ah, ok. Dunno, I will wait on alan's opinion. If I don't heard anything in one
> >week I will apply it.
> 
> Did Simon's patch get applied? I couldn't see it in any of the obvious
> places when I looked the other day.
> 

no, I finally wait for your Acked-by: .... otherwise I will not apply.
That's indicate for me that this patch is okay for you and came into
mainline. There are also pending patches from Varka, if you don't reply
on it, I will not apply it. Should I always simple apply the patches
if you don't response? It's better for me that I see a "Acked-by" from you.

Simon's patch state:
You had some reviewing notes at Simon's patch. I think Simon doesn't
response to this yet. I didn't see any new versions of this.



For DT example you can take a look into at86rf230 driver or cc2520. I
mean examples to add some DT properties. Also if you want to make this
driver dt enabled then you need a documentation in:

Documentation/devicetree/bindings/net/ieee802154/$DRIVERNAME.txt


- Alex
