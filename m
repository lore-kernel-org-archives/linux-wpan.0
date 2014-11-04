Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64544 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaKDMei (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 07:34:38 -0500
Message-ID: <5458C7DB.5060706@xsilon.com>
Date: Tue, 04 Nov 2014 12:34:35 +0000
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: problems with udp header compression
References: <5452081F.5090706@xsilon.com> <5452107B.8010805@xsilon.com> <20141101091052.GB31204@omega>
In-Reply-To: <20141101091052.GB31204@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

I will send a patch. I have done lots of testing and it seems fine.
Do you want the patch based on bluetooth-next?

Simon

On 01/11/14 09:10, Alexander Aring wrote:
> Hi Simon,
>
> On Thu, Oct 30, 2014 at 10:18:35AM +0000, Simon Vincent wrote:
>> This appears to be because if you use a RAW socket with IPPROTO_RAW the ipv6
>> stack passes it straight through and the skb transport_header,
>> network_header offset are not set.
>>
>> Putting the following at the top of compress_udp_header fixes the problem
>> but I am not sure it is safe.
>> if (skb->transport_header == skb->network_header){
>>          skb_set_transport_header(skb,sizeof(struct ipv6hdr));
>>      }
>>
> I see, this could make trouble for IPV6 RAW sockets. Can you please send
> a patch for this and cc linux-bluetooth and linux-wpan. Also add some
> comment why we do this is here, because the RAW socket issue.
>
> Or just send it as RFC (means replace the PATCH into RFC in the
> subject). Then we can talk about a better solution if this isn't a
> perfect solution.
>
> Also remove the unnecessary brackets -> checkpatch should show an error
> because this.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

