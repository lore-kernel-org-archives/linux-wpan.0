Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DC883A.1050304@xsilon.com>
Date: Sat, 02 Aug 2014 07:42:02 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
References: <53DBB278.7090106@xsilon.com> <53DBB610.6020503@pengutronix.de>
In-Reply-To: <53DBB610.6020503@pengutronix.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-zigbee-devel>
List-Post: <mailto:linux-zigbee-devel@lists.sourceforge.net>
List-Help: <mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-zigbee-devel-bounces@lists.sourceforge.net
Subject: Re: [Linux-zigbee-devel] [PATCH bluetooth-next] Simplify lowpan
 receive path so skb is freed in lowpan_rcv when dropped.
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-wpan.vger.kernel.org>

I've just realised I've forgot to ensure skb_inout now points to the new 
skb when copy expanding.
Sorry about that, I'll respin the patch.

- Martin.

On 01/08/14 16:45, Marc Kleine-Budde wrote:
> On 08/01/2014 05:30 PM, Martin Townsend wrote:
>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
>> ---
>>   include/net/6lowpan.h         |  2 +-
>>   net/6lowpan/iphc.c            | 22 +++++++++++++---------
>>   net/bluetooth/6lowpan.c       | 12 ++++++++----
>>   net/ieee802154/6lowpan_rtnl.c | 12 ++++++------
>>   4 files changed, 28 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
>> index d7e9169..aa0381e 100644
>> --- a/include/net/6lowpan.h
>> +++ b/include/net/6lowpan.h
>> @@ -374,7 +374,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>>   
>>   typedef int (*skb_delivery_cb)(struct sk_buff *skb);
>>   
>> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
> Why do you make the first parameter a double pointer?
>
> Marc
>


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel
