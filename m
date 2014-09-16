Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50907 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbaIPUUH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 16:20:07 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so403277wes.19
        for <linux-wpan@vger.kernel.org>; Tue, 16 Sep 2014 13:20:06 -0700 (PDT)
Date: Tue, 16 Sep 2014 22:20:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
Message-ID: <20140916202000.GF6104@omega>
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com>
 <20140916070156.GB1244@omega>
 <541899D8.4020101@componentsw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541899D8.4020101@componentsw.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Walter Mack <wmack@componentsw.com>
Cc: linux-wpan@vger.kernel.org, alan@signal11.us, simon.vincent@xsilon.com

Hi Walter,

On Tue, Sep 16, 2014 at 01:13:12PM -0700, Walter Mack wrote:
> Alex,
> 
> this is not a question of chip revisions. Chips with the same revision can
> be used in designs with or without the external transmitter/receiver. Its
> just that the chip has to be set up to be compatible with the design.
> 

ah, ok. Dunno, I will wait on alan's opinion. If I don't heard anything in one
week I will apply it.

Deal?

Maybe alan wants also add a device tree support for this driver and then we could
make a dt property/platform data for that. But for now, I am also fine with module
parameter solution... because we don't have a dt support right now.

- Alex
