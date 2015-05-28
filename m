Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57758 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbbE1IRp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 28 May 2015 04:17:45 -0400
Message-ID: <5566CF25.4040206@osg.samsung.com>
Date: Thu, 28 May 2015 10:17:41 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] cc2520: update initial transmit power
 value
References: <1432795860-16462-1-git-send-email-varkab@cdac.in> <1432795860-16462-2-git-send-email-varkab@cdac.in> <5566C37A.6060508@gmail.com>
In-Reply-To: <5566C37A.6060508@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

Hello.

On 28/05/15 09:27, Varka Bhadram wrote:
> On 05/28/2015 12:20 PM, Varka Bhadram wrote:
>
>> CC2520 has the default 0dBm transmit power level  on reset.
>> This patch update initial value of transmit power with 0dBm value.
>
> CC2520 has the 0dBm value on reset, but in the driver we are setting
> tx power value to 5dBm.

Why?

In most cases it makes sense to use the same default values the device 
uses as reset values. Why did you decide to use a different value here?

regards
Stefan Schmidt
