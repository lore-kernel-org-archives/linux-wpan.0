Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:44622 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbcCJQjR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 10 Mar 2016 11:39:17 -0500
Subject: =?UTF-8?Q?Re:_PROBLEM=ef=bc=9athere_exists_a_wrong_return_value_of_?=
 =?UTF-8?Q?function_ieee802154=5fadd=5fiface=28=29?=
References: <485cdac3.48e1.1535e928b67.Coremail.rucsoftsec@163.com>
 <20160310090957.GA5020@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56E1A330.5060304@osg.samsung.com>
Date: Thu, 10 Mar 2016 17:39:12 +0100
MIME-Version: 1.0
In-Reply-To: <20160310090957.GA5020@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Zhang Yan <rucsoftsec@163.com>
Cc: linux-wpan@vger.kernel.org

Hello.

Missing a bit context here as the original message never made it to the 
list.

On 10/03/16 10:10, Alexander Aring wrote:
> Hi,
>
> I think this is a good time to remove the deprecated netlink interface
> for 802.15.4.
>
> Stefan please say your opinion here. There should be really nobody which
> use this interface anymore.

My mind haven't really changed on this topic. I understand why you want 
it removed but given that the general rule of the kernel is to have 
backward compatibility we can't just remove it. Dropping the old netlink 
interface breaks userspace compatibility, even if it only is for 
deprecated tools like lowpan-tools, etc.

My take on it is that we live with it. Keeping it around but not 
extending it. Maybe add a warning to dmesg iwhen some application uses 
the old interface.

Is it more code cleanliness/maintenance or bug reports that urge you to 
get rid of it?

regards
Stefan Schmidt
