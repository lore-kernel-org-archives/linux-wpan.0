Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52837 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbaJMQA5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 12:00:57 -0400
Message-ID: <543BF735.4010603@xsilon.com>
Date: Mon, 13 Oct 2014 17:00:53 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC decompression.
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>			 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>		 <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>		 <543BCF44.1030001@xsilon.com>	 <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>	 <543BE816.80304@xsilon.com> <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Jukka,

 From the last trace it looks like a transmit has been started from the receive worker thread.  I notice that both tx and rx use the same workerqueue structure, e.g.

hci_send_xxx
...
queue_work(hdev->workqueue, &hdev->tx_work);


hci_recv_frame
...
queue_work(hdev->workqueue, &hdev->rx_work);


Would this cause problems.  I don't know enough about work queues but in workqueue_struct there is a mutex which may be held by the rx worker and if this rx worker start a transmit maybe this would cause the lock?  Could test by creating separate queues for rx and tx?

Anyway just a thought.

- Martin.


On 13/10/14 16:09, Jukka Rissanen wrote:
> Hi Martin,
>
> On ma, 2014-10-13 at 15:56 +0100, Martin Townsend wrote:
>> Hi Jukka,
>>
>> Does this patch help?
> Unfortunately no, I still see inconsistent lock state. It would probably
> have been too easy :)
>
>> ---
>>  net/bluetooth/l2cap_core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index b6f9777..fb7b2ff 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -5494,6 +5494,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
>>  	if (credits > max_credits) {
>>  		BT_ERR("LE credits overflow");
>>  		l2cap_send_disconn_req(chan, ECONNRESET);
>> +		l2cap_chan_unlock(chan);
>>  
>>  		/* Return 0 so that we don't trigger an unnecessary
>>  		 * command reject packet.
>
> Cheers,
> Jukka
>
>

