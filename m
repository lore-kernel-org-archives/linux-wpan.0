Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57897 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbaIPHFE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 16 Sep 2014 03:05:04 -0400
Message-ID: <1410851097.4860.6.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v3 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 16 Sep 2014 10:04:57 +0300
In-Reply-To: <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com>
References: <1410790194-17502-1-git-send-email-martin.townsend@xsilon.com>
	 <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On ma, 2014-09-15 at 15:09 +0100, Martin Townsend wrote:
> Currently there are a number of error paths in the lowpan_rcv function that
> free the skb before returning, the patch simplifies the receive path by
> ensuring that the skb is only freed from this function.
> 
> Passing the skb from 6lowpan up to the higher layers is not a
> function of IPHC.  By moving it out of IPHC we also remove the
> need to support error code returns with NET_RX codes.
> It also makes the lowpan_rcv function more extendable as we
> can support more compression schemes.
> 
> With the above 2 lowpan_rcv is refacored so eliminate incorrect return values.

I like the idea that we get rid of the callback function.

We could probably refactor the patch a bit further thou as the
lowpan_process_data() could return the skb directly instead of being
passed as a parameter. In the caller we could use the IS_ERR() macro to
check if the returned value is an error or a real pointer.


Cheers,
Jukka


