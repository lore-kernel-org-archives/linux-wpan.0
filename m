Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59726 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaISDYA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 23:24:00 -0400
Message-ID: <541BA138.7080509@gmail.com>
Date: Fri, 19 Sep 2014 08:51:28 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: mrf24j40: remove return
 statement
References: <1410842922-10564-1-git-send-email-varkab@cdac.in> <1410842922-10564-3-git-send-email-varkab@cdac.in> <541B62F6.7000506@signal11.us>
In-Reply-To: <541B62F6.7000506@signal11.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Ott <alan@signal11.us>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

On 09/19/2014 04:25 AM, Alan Ott wrote:
> Make the first line of the commit message:
>     mrf24j40: remove unnecessary return statement
>
> On 09/16/2014 12:48 AM, Varka Bhadram wrote:
>> This patch remove the return statement for void function.
>> void function return statements are not generally useful.
>>
>
> Take out "this patch" and the second line. Make the comment:
>
>     Remove the return statement in the void function.
>
>
Ok. Thanks Alan.

-- 
Regards,
Varka Bhadram.

