Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:49869 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdC2Sva (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Mar 2017 14:51:30 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH][bluetooth-next][V2] ieee802154: ca8210: Add checks for
 kmalloc allocation failures
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170329.101740.93561929292168345.davem@davemloft.net>
Date: Wed, 29 Mar 2017 20:51:26 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <F83769CD-CFDF-460E-8528-ED2CF1D6FC88@holtmann.org>
References: <20170329170540.21011-1-colin.king@canonical.com>
 <20170329.101740.93561929292168345.davem@davemloft.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Colin King <colin.king@canonical.com>, Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, Network Development <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dave,

>> drivers/net/ieee802154/ca8210.c | 18 ++++++++++--------
> 
> This file doesn't exist in any of my trees.
> 

because we have not send you a bluetooth-next pull request yet. I review it and take it through my tree first.

Regards

Marcel

