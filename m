Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:58999 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaJMO42 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 10:56:28 -0400
Message-ID: <543BE816.80304@xsilon.com>
Date: Mon, 13 Oct 2014 15:56:22 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC decompression.
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>		 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>	 <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>	 <543BCF44.1030001@xsilon.com> <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Jukka,

Does this patch help?

---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b6f9777..fb7b2ff 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5494,6 +5494,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (credits > max_credits) {
 		BT_ERR("LE credits overflow");
 		l2cap_send_disconn_req(chan, ECONNRESET);
+		l2cap_chan_unlock(chan);
 
 		/* Return 0 so that we don't trigger an unnecessary
 		 * command reject packet.
-- 
1.9.1


-Martin.

On 13/10/14 15:44, Jukka Rissanen wrote:
> Hi Martin,
>
> and thanks for your analysis.
>
> On ma, 2014-10-13 at 14:10 +0100, Martin Townsend wrote:
>> Hi Jukka,
>>
>> I think there's a lock checking option in the kernel hacking configuration menu.  Might be worth trying this to get more info.
>> I had a quick look through the code and there maybe a potential locking problem in l2cap_le_credits
>> it calls l2cap_get_chan_by_dcid which locks the channel lock (chan->lock) which is one of the locks in the deadlock below.  If credits > max_credits in l2cap_le_credits it returns 0 but no unlock.  Now l2cap_send_disconn_req may do this, I tried searching through but it called a state_change op so I gave up.
>> http://lxr.free-electrons.com/source/net/bluetooth/l2cap_core.c#L5539
>>
>> You could try sticking a  l2cap_chan_unlock(chan); in to see if the problem goes away.
>>
> I managed to trigger the locking issue (by running ssh over bt 6lowpan)
> even without your patch. So I am acking the v6 of this patch. I try to
> dig the root cause to that deadlock issue I am seeing.
>
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
>
>
> Cheers,
> Jukka
>
>

