Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:58037 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164AbaJ3KSi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Oct 2014 06:18:38 -0400
Message-ID: <5452107B.8010805@xsilon.com>
Date: Thu, 30 Oct 2014 10:18:35 +0000
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: problems with udp header compression
References: <5452081F.5090706@xsilon.com>
In-Reply-To: <5452081F.5090706@xsilon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This appears to be because if you use a RAW socket with IPPROTO_RAW the 
ipv6 stack passes it straight through and the skb transport_header, 
network_header offset are not set.

Putting the following at the top of compress_udp_header fixes the 
problem but I am not sure it is safe.
if (skb->transport_header == skb->network_header){
         skb_set_transport_header(skb,sizeof(struct ipv6hdr));
     }


Simon
-
On 30/10/14 09:42, Simon Vincent wrote:
> I think I have stumbled across a bug in the udp header compression or 
> possibly in a higher layer of the network stack.
>
> If I send a UDP message using a RAW socket[0] the src and dest port 
> numbers get corrupted on 802.15.4 devices. This does not occur on 
> ethernet.
>
> If I print out the udp source and destination ports in 
> compress_udp_header they are incorrect. The function udp_hdr is not 
> pointing at the udp header but actually the ip6 header.
>
> If I send a UDP message using a normal UDP socket I do not have this 
> problem.
>
> Any ideas?
>
> Simon
>
> [0] - socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

