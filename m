Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:59656 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752816AbdHJVEJ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 10 Aug 2017 17:04:09 -0400
Date: Thu, 10 Aug 2017 15:04:07 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] doc: linux-wpan: Change the old function names to the
 lastest function names
Message-ID: <20170810150407.4de77816@lwn.net>
In-Reply-To: <20170806162829.2540-1-starnight@g.ncu.edu.tw>
References: <20170806162829.2540-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, linux-doc@vger.kernel.org, linux-wpan@vger.kernel.org

On Mon,  7 Aug 2017 00:28:29 +0800
Jian-Hong Pan <starnight@g.ncu.edu.tw> wrote:

> The function declaration in the lastest include/net/mac802154.h has been
> changed since v3.19.
> 
> ieee802154_alloc_device => ieee802154_alloc_hw
> ieee802154_free_device => ieee802154_free_hw
> ieee802154_register_device => ieee802154_register_hw
> ieee802154_unregister_device => ieee802154_unregister_hw
> 
> However, the description in the Device drivers API section of
> Documentation/networking/ieee802154.txt is still in the state of
> v3.18.63.

Applied to the docs tree with Stefan's ack, thanks.

jon
