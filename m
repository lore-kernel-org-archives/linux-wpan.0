Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:56329 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdAQKIP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Jan 2017 05:08:15 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v7 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <02d9d99c-5cb7-2bfe-6140-5eef3d93ccc6@cascoda.com>
Date: Tue, 17 Jan 2017 11:08:11 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <85E4F697-F359-4E05-AF3A-D74560DB2049@holtmann.org>
References: <20170110154122.6724-1-h.morris@cascoda.com>
 <20170110154122.6724-2-h.morris@cascoda.com>
 <84e02f0a-9b85-888e-be2a-d9d72fd7b7a0@pengutronix.de>
 <02d9d99c-5cb7-2bfe-6140-5eef3d93ccc6@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Harry Morris <h.morris@cascoda.com>
Cc: Alexander Aring <aar@pengutronix.de>, Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>

Hi Harry,

>>> <snip>
>>> +
>>> +	if (ca8210_spi_transfer(
>>> +		device_ref, &command.command_id, command.length + 2)
>>> +	)
>> code style here? Did you run checkpatch?
> checkpatch didn't throw up any complaints regarding style - from what I can see the kernel guidelines are fairly flexible when it comes to splitting long lines. I'm totally happy to newline each argument or something though eg.
> 
> if (ca8210_spi_transfer(
> 	device_ref,
> 	&command.command_id
> 	command.length + 2)
> )

actually checkpatch --strict is what you should be using.

	ca810_spi_transfer(device_ref, &command.command_id,
			   command.length + 2)

Use tabs as much as possible and fill up the rest with spaces to that parameters align. Multiple parameters in the same line is fine. Fill them up as much as possible.

Regards

Marcel

