Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailsender.cdac.in ([196.1.113.117]:49521 "EHLO
	mailsender.cdac.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbE1Iti (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 04:49:38 -0400
Message-ID: <5566D401.6040004@cdac.in>
Date: Thu, 28 May 2015 14:08:25 +0530
From: Varka Bhadram <varkab@cdac.in>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] cc2520: update initial transmit power
 value
References: <1432795860-16462-1-git-send-email-varkab@cdac.in> <1432795860-16462-2-git-send-email-varkab@cdac.in> <5566C37A.6060508@gmail.com> <5566CF25.4040206@osg.samsung.com>
In-Reply-To: <5566CF25.4040206@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Hello,

On 05/28/2015 01:47 PM, Stefan Schmidt wrote:
> Hello.
>
> On 28/05/15 09:27, Varka Bhadram wrote:
>> On 05/28/2015 12:20 PM, Varka Bhadram wrote:
>>
>>> CC2520 has the default 0dBm transmit power level  on reset.
>>> This patch update initial value of transmit power with 0dBm value.
>>
>> CC2520 has the 0dBm value on reset, but in the driver we are setting
>> tx power value to 5dBm.
>
> Why?
>
> In most cases it makes sense to use the same default values the device 
> uses as reset values. Why did you decide to use a different value here?
>
Correct. I need to change that.

Initially we dont have tx power setting from the user-space.
So i just hard coded that value (5dBm) at the time of
hardware initialization.

Now we can set the values from the user-space.


Thanks

-- 
Varka Bhadram


-------------------------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
-------------------------------------------------------------------------------------------------------------------------------

