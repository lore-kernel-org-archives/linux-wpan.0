Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdAGIwO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 7 Jan 2017 03:52:14 -0500
Date: Sat, 7 Jan 2017 09:52:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bluetooth 1/5] ieee802154: atusb: do not use the stack
 for buffers to make them DMA able
Message-ID: <20170107085234.GA20798@kroah.com>
References: <1483748337-4862-1-git-send-email-stefan@osg.samsung.com>
 <1483748337-4862-2-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483748337-4862-2-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, stable@vger.kernel.org

On Sat, Jan 07, 2017 at 01:18:53AM +0100, Stefan Schmidt wrote:
> From 4.9 we should really avoid using the stack here as this will not be DMA
> able on various platforms. This changes the buffers already being present in
> time of 4.9 being released. This should go into stable as well.

It's not just a 4.9 issue, this affects other platforms on all kernel
versions.

> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
