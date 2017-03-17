Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52511 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750967AbdCQMxl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 17 Mar 2017 08:53:41 -0400
Subject: Re: [PATCH v8 0/3] ieee802154: Add support for Cascoda CA8210
References: <20170206170857.5064-1-h.morris@cascoda.com>
 <3E93277B-2B5C-402A-A683-2E94ADEC038F@holtmann.org>
 <9b21db69-6034-4e01-28f0-852ea75d4bd5@cascoda.com>
 <b40da21e-1b49-7b1d-ad85-3086bfad2683@osg.samsung.com>
 <924D8F3E-2D22-48B4-9501-340CB611AA9C@holtmann.org>
 <4d8de4ad-51bf-a3ab-8bdd-b80c71fc6d0d@osg.samsung.com>
 <d7aa153b-3bd4-4052-65c4-c3585e970691@cascoda.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <1f46560a-f28e-3121-c1e9-1bf75061cade@pengutronix.de>
Date: Fri, 17 Mar 2017 13:52:44 +0100
MIME-Version: 1.0
In-Reply-To: <d7aa153b-3bd4-4052-65c4-c3585e970691@cascoda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: h.morris@cascoda.com
Cc: Stefan Schmidt <stefan@osg.samsung.com>, Marcel Holtmann <marcel@holtmann.org>, Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On 03/02/2017 06:42 PM, Harry Morris wrote:
...
> 
> I was looking into this "select vs depends on" and it seems select is by far the more widely used approach when it comes to COMMON_CLK. I guess this doesn't exactly justify it but also I agree having to manually enable it feels a bit unintuitive. I'd appreciate any further thoughts though.
> 

Please note, so far I know:

Select is used mostly on Top Level Entries. It can't solve dependencies...
it can solve it, but then you need also select them in your entry.

Depends on can solve it by make it simple available only if the depended
menu entry is selected.

- Alex
