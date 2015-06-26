Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:50159 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbbFZKOc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 26 Jun 2015 06:14:32 -0400
Message-ID: <558D2605.8080207@osg.samsung.com>
Date: Fri, 26 Jun 2015 12:14:29 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: The 802.15.4 Security Layer
References: <20150618123154.GB6640@omega> <5582E6FA.3020101@osg.samsung.com> <5582EAAD.1090605@xsilon.com> <55831F48.4090905@osg.samsung.com> <55897C92.1060207@xsilon.com> <20150624100011.GA21293@omega> <20150624140111.GA12381@omega> <558D13C4.6000800@xsilon.com> <20150626093218.GA5074@omega> <558D1F3C.8050105@osg.samsung.com> <20150626095844.GA10816@omega>
In-Reply-To: <20150626095844.GA10816@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

Hello.

On 26/06/15 11:58, Alexander Aring wrote:
> On Fri, Jun 26, 2015 at 11:45:32AM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 26/06/15 11:32, Alexander Aring wrote:
>>> On Fri, Jun 26, 2015 at 09:56:36AM +0100, Simon Vincent wrote:
>>>> Ok yes this makes sense.
>>>>
>>>> Let me know if there is any bits I can help on.
>>>>
>>> I added more stuff into the branch [0], fix some embarrassingly mistakes.
>>>
>>> Yesterday I talked with Phoebe about "very simple to use" usecase for
>>> the userspace application.
>>>
>>> In the discussion we end with the idea to have an userspace application
>>> for load/store the security mib.
>>>
>>> Phoebe said it should be something like what iptables do:
>>>
>>> Like "ip6tables-save" and "ip6tables-restore".
>>>
>>> This will simple save the actual mib in a file and restore them from file,
>>> these files should contain the same file format for representing the mib.
>>> Later there should be also the possibility to change the mib during
>>> runtime while a mib is already loaded, but at first the save/restore
>>> sounds the most use case. You can still manipulate the mib security
>>> structure in the configuration file which represents the mib, but need
>>> to run a completely restore afterwards.
>>>
>>>
>>> Maybe we can start a discussion about the "file format" which represents
>>> the mib. This should be some simple format. Not xml/json which
>>> adds library dependencies.
>>>
>> I'm still not 100% sold on the idea that we only want to allow the whole sec
>> mib to be loaded and saved and not single properties. Having the option to
>> set/get single mib sec properties would be useful and in line with all the
>> other properties we handle in iwpan right now.
>>
> That's what I trying to explain at sentence:
>
> "Later there should be also the possibility to change the mib during
> runtime while a mib is already loaded..."
>
> of course that should be possible, but for now the first use case would
> only to store/restore the security mib.
>
> Nevertheless store/restore security should be use some small netlink
> cmd's which use already the interface to implement such manipulation
> over e.g. iwpan command line.
>
>> What I capture from your and Phoebe's mails is that you want to have one
>> policy file with all options in them to avoid broken configurations and
>> problems to debug this, right?
>> We still would need logic inside iwpan to detect and ignore these invalid
>> configs. We could use the same logic when setting single properties.
>>
> What I get was, everytime when you doing a reboot you need to
> store/restore them like in iptables.
>
> (Single properties), yes this is of course available then. I mean it
> depends, the current interface doesn't allow to make small changes like
> in a key structure. We allow to del a key and then add a new key
> afterwards. All these things are possible to making a fine granularity
> setting, but the first use case a store/restore would be fine to have
> something that is working and solve the most use case.
>

Thanks for clarifying this. I understood it differently. Having the 
safe/restore way at fist only make sebse and is totally fine with me. I 
just thought it was the only planned way.

>> Don't get me wrong I'm fine having one file with all options in it I just
>> think that having the possibility to set them individually might aloy be a
>> benefit.Maybe I over engineer it. Don't know.
>>
>> Coming back to the file format. I like the plain ini format for such cases.
>> Its' plain text but still has some strcutre and key value pairs. A realy
>> benefit imho is that it is also easy to read and modified by humans.
>>
> Does ini files also handling list and hierarchy strutures? What I did
> previously was to wrote something with flex/bison. I am not an expert in
> flex/bison, but parsing config files should be "hopefully" simple
> enough. List handling we need for e.g. seclevels and the hierarchy
> functionality we need e.g. not to write everytime the key_id for
> identify the key.

Not sure I get what you mean here. Maybe we should start with what data 
we want to store and what inter deps they have.

The ini format is pretty simple. Basically categories and key value 
pairs. If we want more we might need something else.

regards
Stefan Schmidt
