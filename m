Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38054 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbeGBVbr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jul 2018 17:31:47 -0400
Received: by mail-it0-f66.google.com with SMTP id v83-v6so307374itc.3
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jul 2018 14:31:47 -0700 (PDT)
Date: Mon, 2 Jul 2018 17:31:40 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
Message-ID: <20180702213140.noxt6vr46xpiwjaq@x220t>
References: <20180619234406.8217-1-michael@opensourcefoundries.com>
 <20180702185438.dqqjg6k45iefj5is@x220t>
 <516fbc65-cc4b-8016-de5a-e2240b779d15@opensourcefoundries.com>
 <20180702204346.d7bynetvzw3ayn5m@x220t>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702204346.d7bynetvzw3ayn5m@x220t>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Scott <michael@opensourcefoundries.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 02, 2018 at 04:43:46PM -0400, Alexander Aring wrote:
> Hi,
> 
> On Mon, Jul 02, 2018 at 12:45:41PM -0700, Michael Scott wrote:
> > Hello Alexander,
> > 
> ...
> > > Question is for me: which upper layer wants access MAC header here on
> > > receive path?
> > > It cannot parsed anyhow because so far I know no upper layer can parse
> > > at the moment 802.15.4 frames (which is a complex format). Maybe over
> > > some header_ops callback?
> > 
> > I was testing a C program which performs NAT64 handling on packets
> > destined to a certain IPv6 subnet (64:ff9b::). To do this, the application
> > opens a RAW socket like this: sniff_sock = socket(PF_PACKET, SOCK_RAW,
> > htons(ETH_P_ALL)); It then sets promiscuous mode and enters a looping call
> > of:
> > length = recv(sniff_sock, buffer, PACKET_BUFFER, MSG_TRUNC); My host PC
> > kernel would then promptly crash on me. (I'm going to purposely avoid the
> > obvious point of: this probably isn't the best way to parse packets for
> > NAT64 translation as you will get every single packet incoming or outgoing
> > on the host.) Turns out, testing the program on an 802.15.4 6lowpan
> > interface exposed some of the issues which this mailing list (but not
> > myself) is well aware of (no L2 data in the RAW packets) and also led me to
> > debugging this patch to stop the kernel crash. TL;DR: To summarize, any
> > PF_PACKET SOCK_RAW socket which recv()'s IPv6 data from a 6lowpan node will
> > cause this kernel crash eventually (checked on kernel 4.15, 4.16, 4.17 and
> > 4.18-rc1). - Mike
> > > 
> 
> "any PF_PACKET SOCK_RAW" can't be otherwise I would also see it with my
> sniffer programs e.g. wireshark or tcpdump which use libpcap.
> 
> There need to be some different in the handling. This is what I have
> currently in my mind.
> 
> I currently not sure how to set skb->mac_header if interface is RAW_IP.
> It seems there is an indicator that mac header is not set. Example:
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 6b1042e21656..e6ec2df3afe0 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>                 hdr.hop_limit, &hdr.daddr);
>  
>         skb_push(skb, sizeof(hdr));
> +       skb->mac_header = (typeof(skb->mac_header))~0U;
>         skb_reset_network_header(skb);
>         skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
>  
> 
> Maybe we should lookup what skb->mac_header points to on tun interfaces
> then do the same.

So far I see [0] tun does the same as your patch approach does. network
header and mac header points to the same.

I think then we should go with your patch.

Then we just need to solve the issue to get mac header information on
top of lowpan socket layer... out of scope issue but indeed we need to
solve that. As we talked there exists even UDP protocols which needs mac
header information. It's in a pretty early state, I have no idea how
this fits sometimes with fragmentation handling together. At least for
L2 address handling and fragmentation it should be fine (one of the
fragment indentifier).

- Alex

[0] https://elixir.bootlin.com/linux/v4.18-rc3/source/drivers/net/tun.c#L1912
