Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62781 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaIRSah (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 14:30:37 -0400
Message-ID: <541B24CA.1090404@xsilon.com>
Date: Thu, 18 Sep 2014 19:30:34 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Promiscuous patches
References: <20140918123024.GB6777@omega> <20140918124430.GA8268@omega> <541ADD3B.8090706@xsilon.com> <20140918133424.GA8458@omega> <20140918134210.GB8458@omega> <541AEE07.8030804@xsilon.com> <20140918160458.GB9262@omega> <541B0E3B.9000201@xsilon.com> <20140918170724.GA11661@omega> <20140918175405.GC11661@omega> <20140918175617.GA12638@omega>
In-Reply-To: <20140918175617.GA12638@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex
On 18/09/14 18:56, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 07:54:05PM +0200, Alexander Aring wrote:
>> Again me,
>>
>> On Thu, Sep 18, 2014 at 07:07:24PM +0200, Alexander Aring wrote:
>>> Hi Martin,
>>>
>>> On Thu, Sep 18, 2014 at 05:54:19PM +0100, Martin Townsend wrote:
>>>> Hi Alex,
>>>>
>>>> On 18/09/14 17:05, Alexander Aring wrote:
>>>>> Hi Martin,
>>>>>
>>>>> On Thu, Sep 18, 2014 at 03:36:55PM +0100, Martin Townsend wrote:
>>>>>> On 18/09/14 14:42, Alexander Aring wrote:
>>>>>>> On Thu, Sep 18, 2014 at 03:34:24PM +0200, Alexander Aring wrote:
>>>>>>> ...
>>>>>>>>> I want to be able from COORD or NODE mode to put the device in promiscuous mode so packets can be received by wireshark.  For example if we are seeing a problem on a device, I want to be able to ssh into this node via Ethernet (or maybe connect via the serial console) and run tcpdump -U -i wpan0 to help debugging by seeing what packets are being sent/received.  As it's going to stdout it will be sent over ssh and I can then do some pipe redirection to pipe it into Wireshark running on a different machine.
>>>>>>>>>
>>>>>>>>>  From my understanding this is not MONITOR mode and I don't won't to put the device into MONITOR mode as this could effect it's functionality.
>>>>>>>>> I'm currently looking at how tcpdump does this and it looks like it uses a raw socket using PF_PACKET.  I think it then sets the IFF_PROMISC flag on this socket to put the device into promiscuous mode.  As I'm in COORD or NODE mode this will arrive at the ndo_change_rx_flags for the net device ops defined in wpan.c not monitor.c in my linux tree.
>>>>>>> Has nothing to do with raw sockets, I think.
>>>>>> I'm just going on what I'm seeing in libpcap, I think tshark and tcpdump both use this library.  If you have a debug environment setup, set a breakpoint on activate_new or look through pcap-linux.c, one of the first things it does is:
>>>>>>      sock_fd = is_any_device ?
>>>>>>          socket(PF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL)) :
>>>>>>          socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
>>>>>>
>>>>>> is_any_device should be set to false as we are capturing a specific device so we should be creating a raw socket.  Then later on
>>>>>>      if (!is_any_device && handle->opt.promisc) {
>>>>>>          memset(&mr, 0, sizeof(mr));
>>>>>>          mr.mr_ifindex = handlep->ifindex;
>>>>>>          mr.mr_type    = PACKET_MR_PROMISC;
>>>>>>          if (setsockopt(sock_fd, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
>>>>>>              &mr, sizeof(mr)) == -1) {
>>>>>>              snprintf(handle->errbuf, PCAP_ERRBUF_SIZE,
>>>>>>                  "setsockopt: %s", pcap_strerror(errno));
>>>>>>              close(sock_fd);
>>>>>>              return PCAP_ERROR;
>>>>>>          }
>>>>>>      }
>>>>>> Then I think this ends up in the kernel at packet_dev_mc
>>>>>> http://lxr.free-electrons.com/source/net/packet/af_packet.c#L3060
>>>>>> which calls dev_set_promiscuity.
>>>>>>
>>>>> yes, there existing any magic for capturing all interface incomming and
>>>>> outcomming data. But I don't know now how this is related currently.
>>>>>
>>>>> You exacly want the incomming/outcomming data of an interface and that's
>>>>> what the default behaviour is. There existing also some netdev flag
>>>>> which activate this the "IFF_PROMISC". But then we don't need any
>>>>> handling to turn the device driver into any special mode?
>>>>>
>>>>> We already support the promiscuous mode. I mean the normal capturing of
>>>>> interface data and this is the default behaviour, we don't need any
>>>>> extra implementation to make something when rx flag IFF_PROMISC is set.
>>>>>
>>>>> Is there something missing now, which we should support when activate
>>>>> wireshark & co on a wpan interface?
>>>>>
>>>>> - Alex
>>>> I thought the default behaviour was to filter? Currently we implement the hw
>>>> filter driver op function and our HW implements the third level of filtering
>>>> as per 802.15.4 spec so by default we only get packets for our PAN/Address.
>>>> I think one of the user space functions, probably iz sends a netlink command
>>>> which invokes the driver operation to set the filter up in the driver.
>>>> So I want to use set promisc to disable this HW filter and let all packets
>>>> through.
>>> But this is MONITOR iftype then "to see all packets without filtering".
>>> Doing a ifup on a MONITOR interface will enable the HW promiscuous mode.
>>>
>> do hw promiscuous while setting IFF_PROMISC, please don't do this. It isn't
>> easy to handle because we have these multiple interfaces tupes. Simple have a
>> monitor interface type which enables HW promiscuous mode while interface
>> up. (ifconfig foo0 up, ip set link dev foo0 up)
>>
>> Again look at rework code what I did there [0].
OK I will have look again at [0], I think I am missing something.
> and I hope we clarified now that promiscuous mode with NODE/WPAN type
> doesn't make any sense than increasing cpu load. You don't get more
> frames into userspace.
We are implementing 802.15.4 on powerline.  If we had say a peer to peer 
network involving 4 different PANs and because we aren't restricted by 
distance as much as wireless we could potentially put one of the 
Coordinator nodes into promiscuous mode and then capture traffic from 
all 4 PAN's whereas if we are filtering we only see the traffic for the 
PAN(s) we are involved in.  Wouldn't this be more frames that just the 
filter?

> - Alex
- Martin.
- Martin
