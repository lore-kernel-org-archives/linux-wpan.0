Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:46256 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761012AbdEWSGc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 May 2017 14:06:32 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH net v2 1/2] net: ieee802154: remove explicit set skb->sk
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1495516865-17019-1-git-send-email-xiaolou4617@gmail.com>
Date: Tue, 23 May 2017 11:06:26 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <B3524543-D8CC-4BC8-AE22-4C228C14BFB8@holtmann.org>
References: <1495516865-17019-1-git-send-email-xiaolou4617@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lin Zhang <xiaolou4617@gmail.com>
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Lin,

> Explicit set skb->sk is needless, sock_alloc_send_skb is already set it.
> 
> Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
> Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> changelog:
> 
> v1 -> v2:
>        * split v1 into two patches, per Stefan Schmidt.
> 
> Thanks to Stefan Schmidt for reviewing !
> ---
> net/ieee802154/socket.c | 2 --
> 1 file changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

