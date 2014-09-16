Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60689 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbaIPOot (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 10:44:49 -0400
Message-ID: <54184CDB.9050200@xsilon.com>
Date: Tue, 16 Sep 2014 15:44:43 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
References: <20140916115357.GE4969@omega> <20140916120247.GA5217@omega> <20140916121844.GA5349@omega> <54182C6B.6090801@xsilon.com> <20140916123421.GA5576@omega> <54182FB8.4080103@xsilon.com> <20140916124832.GB5576@omega> <1410873619.4860.20.camel@jrissane-mobl.ger.corp.intel.com> <20140916133206.GA6104@omega> <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com> <20140916140459.GB6104@omega>
In-Reply-To: <20140916140459.GB6104@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

I would like to keep freeing skb's out of process_data as process_data will become something like iphc_decompress_hdr and it would be good if that's all it did.  Otherwise I feel we are going to put a constraint on all future header decompression routines in that they must free the skb on error.  I think it would be better to defer this so on error you might want to try something else with the skb, maybe not but at least the option is there.
So how about

        struct sk_buff * ret_skb;
        switch (skb->data[0] & 0xe0) {
        case LOWPAN_DISPATCH_IPHC:    /* ipv6 datagram */
            ret_skb = process_data(skb, &hdr);
            if (IS_ERR(ret_skb))
                goto drop_skb;
            else
                skb = ret_skb;
            break;

I know we currently have 3 calls to process_data so it will look fairly ugly in this patch but in my next patch to fix lowpan_rcv to handle uncompressed IPv6 packets that are fragmented there will only be one call to process_data so it won't look so bad.  You could even wrap it in a macro but I'm not a fan of this as they can obfuscate the code a bit.

Thoughts?

- Martin.



On 16/09/14 15:05, Alexander Aring wrote:
> Hi Jukka and Martin,
>
> On Tue, Sep 16, 2014 at 04:52:50PM +0300, Jukka Rissanen wrote:
> ...
>> Great, your example clarified the issue nicely :)
>>
>> I would vote for option 2) but if it makes the code too ugly then 1) is
>> ok too.
>>
> I begin to have the feeling like there is a reason because there are
> different indicators for consume_skb, kfree_skb. Error or not error,
> because it's hard to implement it in some way to make a correct handling
> without using a pointer of pointer. A pointer of pointer always means also
> a unnecessary dereferencing (netdev people doesn't like unnecessary
> dereferencing stuff, takes too much time).
>
> That's why I vote also for option 2)... but we can also clarify this on
> the netdev mailinglist and ask other networking kernel hackers.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

