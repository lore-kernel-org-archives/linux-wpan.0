Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:60653 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbdC0OsL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Mar 2017 10:48:11 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v8 0/3] ieee802154: Add support for Cascoda CA8210
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1f46560a-f28e-3121-c1e9-1bf75061cade@pengutronix.de>
Date: Mon, 27 Mar 2017 16:46:34 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <75B6F7AE-3064-4D1D-9264-3B0C15BBC778@holtmann.org>
References: <20170206170857.5064-1-h.morris@cascoda.com>
 <3E93277B-2B5C-402A-A683-2E94ADEC038F@holtmann.org>
 <9b21db69-6034-4e01-28f0-852ea75d4bd5@cascoda.com>
 <b40da21e-1b49-7b1d-ad85-3086bfad2683@osg.samsung.com>
 <924D8F3E-2D22-48B4-9501-340CB611AA9C@holtmann.org>
 <4d8de4ad-51bf-a3ab-8bdd-b80c71fc6d0d@osg.samsung.com>
 <d7aa153b-3bd4-4052-65c4-c3585e970691@cascoda.com>
 <1f46560a-f28e-3121-c1e9-1bf75061cade@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: h.morris@cascoda.com, Stefan Schmidt <stefan@osg.samsung.com>, Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org

Hi,

>> I was looking into this "select vs depends on" and it seems select is by far the more widely used approach when it comes to COMMON_CLK. I guess this doesn't exactly justify it but also I agree having to manually enable it feels a bit unintuitive. I'd appreciate any further thoughts though.
>> 
> 
> Please note, so far I know:
> 
> Select is used mostly on Top Level Entries. It can't solve dependencies...
> it can solve it, but then you need also select them in your entry.
> 
> Depends on can solve it by make it simple available only if the depended
> menu entry is selected.

can someone send me a version of this patchset where this is solved?

Regards

Marcel

