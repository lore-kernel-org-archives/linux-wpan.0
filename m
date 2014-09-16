Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57639 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201AbaIPTxU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 15:53:20 -0400
Message-ID: <54189522.9090405@xsilon.com>
Date: Tue, 16 Sep 2014 20:53:06 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
References: <20140916123421.GA5576@omega> <54182FB8.4080103@xsilon.com> <20140916124832.GB5576@omega> <1410873619.4860.20.camel@jrissane-mobl.ger.corp.intel.com> <20140916133206.GA6104@omega> <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com> <20140916140459.GB6104@omega> <54184CDB.9050200@xsilon.com> <20140916173806.GC6104@omega> <54188817.80707@xsilon.com> <20140916193723.GD6104@omega>
In-Reply-To: <20140916193723.GD6104@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

On 16/09/14 20:37, Alexander Aring wrote:
> On Tue, Sep 16, 2014 at 07:57:27PM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> On 16/09/14 18:38, Alexander Aring wrote:
>>> Hi Martin,
>>>
>>> On Tue, Sep 16, 2014 at 03:44:43PM +0100, Martin Townsend wrote:
>>>> I would like to keep freeing skb's out of process_data as process_data will become something like iphc_decompress_hdr and it would be good if that's all it did.  Otherwise I feel we are going to put a constraint on all future header decompression routines in that they must free the skb on error.  I think it would be better to defer this so on error you might want to try something else with the skb, maybe not but at least the option is there.
>>>> So how about
>>>>
>>>>          struct sk_buff * ret_skb;
>>>>          switch (skb->data[0] & 0xe0) {
>>>>          case LOWPAN_DISPATCH_IPHC:    /* ipv6 datagram */
>>>>              ret_skb = process_data(skb, &hdr);
>>>>              if (IS_ERR(ret_skb))
>>>>                  goto drop_skb;
>>>>              else
>>>>                  skb = ret_skb;
>>>>              break;
>>>>
>>>> I know we currently have 3 calls to process_data so it will look fairly ugly in this patch but in my next patch to fix lowpan_rcv to handle uncompressed IPv6 packets that are fragmented there will only be one call to process_data so it won't look so bad.  You could even wrap it in a macro but I'm not a fan of this as they can obfuscate the code a bit.
>>>>
>>>> Thoughts?
>>>>
>>> sorry, I can't follow how this solve the issue if the "parameter skb" is
>>> already consumed or not. If process_data returns a error before
>>> parameter consume, then we should run kfree_skb(parameter_skb), if it's
>>> afterwards we should do nothing. Point is we don't know that there. I
>>> suppose if we do consume_skb and refcount reach 0 the parameter_skb
>>> becomes a dangling pointer.
>>>
>>> - Alex
>> process_data never consumes the skb, it may copy_expand and then consume the
>> old one so it will either return an error or an skb that contains the
>> uncompressed ipv6 header.  By calling process_data using a different sk_buff
>> pointer (ret_skb) that the parameter we can check this for an error and if
>> so goto drop_skb which will kfree_skb(skb) which is fine as skb is still
> are you sure it's still valid? I don't get it. :-(
>
>> valid.   if ret_skb is good and we assign to skb and carry on to the
>> function that  passes the skb up the stack, lowpan_give_skb_to_devices,
>> which deals with either consuming or kfreeing.
>>
>> Or am I missing something?
>>
> I make another c example, hopeful more correct than the last one:
>
> char *foo(char *skb)
> {
>          char *new;
>
>          if (some_error_before_consume)
>                  return ERR_PTR(-EINVAL); /* here we need to do a free(skb) */
>
>          /* UDP expand */
>          new = expand(skb, 16);
>          if (!new)
>                  return ERR_PTR(-ENOMEM);
>          consume(skb); /* parameter skb becomes dangling pointer */
>          skb = new; /* doesn't rescue it, it is different than skb from caller function
>                        at this point, the skb_inout had rescue it, because it was a pointer
>                        of pointer */
>
>          /* IPv6 expand */
>          new = expand(skb, 40);
>          if (!new) /* some error after a consume(skb), will crash at drop_skb label */
>                  return ERR_PTR(-ENOMEM);
>          consume(skb);
>          skb = new;
>
>          return skb;
> }
I see the problem now, once the skb has been copied and then an error 
occurs you have to return the error and the skb has been lost.  Would 
using the skb->cb to store decompress status get around this problem?
> int main(int argc, const char *argv[])
> {
>          char *local_buf = malloc(42);
>          char *skb;
>
>          local_skb = foo(skb);
>          if (IS_ERR(local_skb))
>                  goto drop_skb;
>          else
>                  skb = local_skb; /* ??? */
>
>          return NET_RX_SUCCESS;
>
> drop_skb:
>          free(skb); /* dangling pointer will be freed if foo called consume(skb)
>                        it's correct when foo returned on some_error_before_consume
>                        condition. */
> drop:
>          return NET_RX_DROP;
> }
>
> I don't know what "skb = local_skb" did now there.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
- Martin.
