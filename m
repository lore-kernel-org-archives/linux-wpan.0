Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37648 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbcC3BnT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 29 Mar 2016 21:43:19 -0400
Received: by mail-ig0-f180.google.com with SMTP id l20so29755289igf.0
        for <linux-wpan@vger.kernel.org>; Tue, 29 Mar 2016 18:43:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160329083732.GA1114@omega>
References: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
	<20160329083732.GA1114@omega>
Date: Wed, 30 Mar 2016 08:43:18 +0700
Message-ID: <CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
Subject: No device found for binding socket ieee802.15.4
From: Adika Bintang Sulaeman <adikabintang78@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, stefan@osg.samsung.com, jukka.rissanen@linux.intel.com

Hi Alexander Aring,

I have watched your presentation on [1] and I saw that you had the
"Link encap: UNSPEC" as well. Thank you for your explanation. I hope I
can get some directions or hints about the problem I face on running
"wpan-ping --daemon" and the socket for 802.15.4.

[1] https://archive.fosdem.org/2015/schedule/event/deviot09/

On 3/29/16, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> On Mon, Mar 28, 2016 at 10:46:04PM +0700, Adika Bintang Sulaeman wrote:
>> Dear all linux-wpan developers and users,
>>
>> This is my first time exploring 6LoWPAN and I would like to ask you
>> some questions. Before getting into questions, these are the devices
>> and set up that I use:
>> -Raspberry Pi Model B Rev 2
>> -Raspbian OS
>> -kernel from bluetooth-next ver 4.5.0-rc5+
>> -MRF24J40MA Transceiver
>>
>> After setting up and installing the wpan-tools, I got my interface
>> work by prompting "ip link show" and there is something like:
>>
>> 3: wpan0 <BROADCAST,NOARP> mtu 123 qdisc noop state DOWN mode DEFAULT
>> group default qlen 1000
>>         link/ieee802.15.4 ee:3b:07:84:64:8c:2a:71 brd
>> ff:ff:ff:ff:ff:ff:ff
>>
>> The first thing I notice strange is why after the command "sudo ip
>> link add link wpan0 name lowpan0 type lowpan" the output in "ip link
>> show" is a bit different, especially in link/[825]:
>>
>> 7: lowpan0 <BROADCAST,MULTICAST> mtu 1280 qdisc noop state DOWN mode
>> DEFAULT group default qlen 1
>>         link/[825] ee:3b:07:84:64:8c:2a:71 brd ff:ff:ff:ff:ff:ff:ff
>>
>> So this is the FIRST QUESTION:
>> 1. Is that normal/ok to have link/[825] instead of link/ieee802.15.4?
>>
>
> It's okay. lowpan0 != wpan0 these are different interfaces. It should be
> link/6lowpan, but this interface type is just too new and iproute2
> doesn't know it. That's why it shows the identifier of such type.
>
> We need a patch for iproute2:
>
> diff --git a/lib/ll_types.c b/lib/ll_types.c
> index 2c5bf8b..6c71c8b 100644
> --- a/lib/ll_types.c
> +++ b/lib/ll_types.c
> @@ -35,6 +35,7 @@ static const struct {
>         const char *name;
>  } arphrd_names[] = {
>  { 0, "generic" },
> +__PF(6LOWPAN,6lowpan)
>  __PF(ETHER,ether)
>  __PF(EETHER,eether)
>  __PF(AX25,ax25)
>
> Feel free somebody to submit such patch! I cc jukkar here, because this
> issue is related to btle 6lowpan also. btw: I didn't test it, just
> compile.
>
> The 6lowpan interface is the same type for 802.15.4 6LoWPAN and BTLE
> 6loWPAN, see slides [0].
>
>> The second thing I notice strange is after "sudo ip link set wpan0 up"
>> for both wpan0 and lowpan0, the "ifconfig" command shows that these
>> network interfaces have "Link encap:UNSPEC". If I'm not mistaken, Link
>> encap shows the hardware family of the interface, right?
>>
>> So the SECOND QUESTION is:
>> 2. Is that normal/ok to have Link encap:UNSPEC? Because this thing
>> makes me suspicious about the next problem that I face.
>>
>
> I think this requires a similar fix like above for "ifconfig". It's just
> eyecandy. Remember: ip > ifconfig, because ifconfig is deprecated.
>
>> I tried to run wpan-ping daemon from /wpan-tools/wpan-ping by
>> prompting "wpan-ping --daemon" but the output is "bind: No such
>> device". I tried to make my own code to make a server program which
>> listen to this socket interface. But when binding with bind(), I got
>> the same error status "No device found".
>>
>> This leads to my THIRD QUESTION:
>> 3. Why "no device found" appears? The transceiver is attached, the
>> hardware address exists, the interface is up, and I am able to ping
>> between two devices using ping6. I am suspicious that the problems
>> that I ask you before have caused this problem.
>>
>> Do you know what's wrong here?
>>
>
> Don't know, I never tried the socket interface for 802.15.4. Stefan
> Schmidt did some stuff there, maybe he can help here.
>
> btw: the socket interface need a complete rework/cleanup. [1]
>
> What I test is the raw socket interface over AF_PACKET for 802.15.4
> interfaces.
>
> - Alex
>
> [0]
> http://www.netdevconf.org/1.1/proceedings/slides/aring-generic-6lowpan-branch.pdf
> [1] https://github.com/linux-wpan/linux-wpan/issues/20
>
