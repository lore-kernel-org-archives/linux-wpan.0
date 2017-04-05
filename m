Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:49156 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbdDENrS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Apr 2017 09:47:18 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] Bluetooth: 6lowpan: Remove unnecessary peer lookup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170403144857.4661-1-luiz.dentz@gmail.com>
Date: Wed, 5 Apr 2017 15:47:15 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <6D8C6EC7-4E52-4C4B-8A2D-728880DDF938@holtmann.org>
References: <20170403144857.4661-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>, Alexander Aring <aar@pengutronix.de>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org

Hi Luiz,

> During chan_recv_cb there is already a peer lookup which can be passed
> to recv_pkt directly instead of the channel.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/6lowpan.c | 15 ++++-----------
> 1 file changed, 4 insertions(+), 11 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

