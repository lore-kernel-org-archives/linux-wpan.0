Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:32914 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbbFII4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 04:56:37 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next] ieee802154/mrf24j40: make sure we do not override return values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433839946-20877-1-git-send-email-stefan@osg.samsung.com>
Date: Tue, 9 Jun 2015 10:56:31 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <F30AE19E-4B95-431D-B433-ADEADBF7DE65@holtmann.org>
References: <1433839946-20877-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

Hi Stefan,

> If we run into an error during rx we set the the error code in ret, but override
> it afterwards. Using a different variable for the extra case avoids this
> situation.
> 
> CID: 1226982, 1226983
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> Cc: Alan Ott <alan@signal11.us>
> ---
> drivers/net/ieee802154/mrf24j40.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

