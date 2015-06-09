Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:34822 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbbFIHoM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 03:44:12 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] mac802154/iface: remove superfluous WARN_ON call in slave_open()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433794000-10501-1-git-send-email-stefan@osg.samsung.com>
Date: Tue, 9 Jun 2015 09:44:09 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <91533802-A501-45BF-A311-DA45E6BAD6BF@holtmann.org>
References: <1433794000-10501-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hi Stefan,

> This call was used before we aligned our code with the wireless code base. We
> are wanted to handle this in the err: code path. Which would actually not work
> because the WARN_ON() macro would reset the res value to 0 and thus we would
> never hit err:. Removing it makes the code do what we actually intend.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> net/mac802154/iface.c | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

