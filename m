Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64652 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaJAJoF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 05:44:05 -0400
Message-ID: <542BCCE0.8070408@xsilon.com>
Date: Wed, 01 Oct 2014 10:44:00 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Problems with fakeserial
References: <542ACF52.3030807@xsilon.com> <20141001003814.GB1007@omega> <542BB5B1.5010705@xsilon.com> <20141001081102.GA25131@omega> <20141001081655.GB25131@omega>
In-Reply-To: <20141001081655.GB25131@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

Just testing the new changes now :)

- Martin.

On 01/10/14 09:16, Alexander Aring wrote:
> On Wed, Oct 01, 2014 at 10:11:02AM +0200, Alexander Aring wrote:
>> Hi Martin,
>>
>> On Wed, Oct 01, 2014 at 09:05:05AM +0100, Martin Townsend wrote:
>>> Hi Alex,
>>>
>>> Do you know where I can find the serial driver module?
>>>
>> yes, the last known version for me is this what Tony Chenau did. [0]
>>
> s/Chenau/Cheneau/
>
> and please don't forget the fix for error handling at lowpan_rcv. When
> do you want to send a new patch version for that?
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

