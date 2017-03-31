Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:37262 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbdCaKKa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 31 Mar 2017 06:10:30 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] bluetooth: 6lowpan: fix use after free in
 chan_suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170329061018.4243-1-michael.scott@linaro.org>
Date: Fri, 31 Mar 2017 12:10:27 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <2B4AB0D3-D55D-4F3F-ACA6-F82DC680316E@holtmann.org>
References: <20170329061018.4243-1-michael.scott@linaro.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Scott <michael.scott@linaro.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Michael,

> A status field in the skb_cb struct was storing a channel status
> based on channel suspend/resume events.  This stored status was
> then used to return EAGAIN if there were packet sending issues
> in snd_pkt().
> 
> The issue is that the skb has been freed by the time the callback
> to 6lowpan's suspend/resume was called.  So, this generates a
> "use after free" issue that was noticed while running kernel tests
> with KASAN debug enabled.
> 
> Let's eliminate the status field entirely as we can use the channel
> tx_credits to indicate whether we should return EAGAIN when handling
> packets.
> 
> Signed-off-by: Michael Scott <michael.scott@linaro.org>
> ---
> net/bluetooth/6lowpan.c | 21 +++------------------
> 1 file changed, 3 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

